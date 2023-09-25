import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:structure/components/show_error_view.dart';
import 'package:structure/dataSource/firebase_services.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

class InsertionMeatImageViewModel with ChangeNotifier {
  final MeatModel meatModel;
  final UserModel userModel;
  // 반드시 들어올 페이지에 함께 넣어주어야 한다!
  final int imageIdx;

  InsertionMeatImageViewModel({
    required this.meatModel,
    required this.userModel,
    required this.imageIdx,
  });

  late DateTime time;
  File? pickedImage;
  String? imagePath;
  bool isImageAssigned = false;
  bool isLoading = false;

  void fetchDate(String dateString) {
    DateTime? date = parseDate(dateString);
    print(dateString);
    if (date != null) {
      time = date;
    } else {
      print('DateString format is not valid.');
    }
  }

  DateTime? parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  void fetchImage() {
    if (imageIdx == 0 && meatModel.imagePath != null) {
      isImageAssigned = true;
      fetchDate(meatModel.createdAt!);
      imagePath = meatModel.imagePath;
      pickedImage = File(imagePath!);
    } else if (imageIdx == 2 && meatModel.deepAgedImage != null) {
      isImageAssigned = true;
      fetchDate(meatModel.createdAt!);
      imagePath = meatModel.deepAgedImage;
      pickedImage = File(imagePath!);
    }
    notifyListeners();
  }

  // 이미지 촬영을 위한 메소드
  void pickImage() async {
    final imagePicker = ImagePicker();

    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    isLoading = true; // 로딩 활성화
    notifyListeners();

    if (pickedImageFile != null) {
      // 촬영한 이미지를 저장한다.
      imagePath = pickedImageFile.path;
      pickedImage = File(pickedImageFile.path);
      time = DateTime.now();
      isImageAssigned = true;
    }

    isLoading = false; // 로딩 비활성화
    notifyListeners();
  }

  Future<void> saveMeatData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    if (imageIdx == 0) {
      // 원육 사진
      meatModel.imagePath = imagePath;
      meatModel.createdAt = '${time.year}${time.month.toString().padLeft(2, '0')}${time.day.toString().padLeft(2, '0')}';
    } else if (imageIdx == 2) {
      // 처리육 사진(딥에이징) - 바로 전송
      meatModel.deepAgedImage = imagePath;
      dynamic response = await FirebaseServices.sendImageToFirebase(imagePath!, 'sensory_evals/${meatModel.id}-${meatModel.seqno}');
      if (response == null) {
        // if (!mounted) return;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ShowError(),
        //   ),
        // );
      }
    } else {
      print('imageIdx 에러');
    }

    isLoading = false;
    notifyListeners();
  }
}
