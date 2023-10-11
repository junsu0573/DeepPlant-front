import 'dart:io';
import 'dart:typed_data';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class RegistrationMeatImageViewModel with ChangeNotifier {
  final MeatModel meatModel;

  RegistrationMeatImageViewModel(this.meatModel) {
    _fetch();
  }

  String date = '-';
  String userName = '-';

  late DateTime time;

  String? imagePath;
  bool isLoading = false;

  File? imageFile;

  void fetchDate(String dateString) {
    DateTime? date = parseDate(dateString);

    if (date != null) {
      time = date;
    } else {
      print('DateString format is not valid.');
    }
  }

  void _setInfo() {
    time = DateTime.now();
    date = '${time.year}.${time.month}.${time.day}';
    userName = meatModel.userId ?? '-';
  }

  DateTime? parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  void _fetch() {
    if (meatModel.seqno == 0) {
      // 원육 데이터
      // 등록, 수정
      imagePath = meatModel.imagePath;
      if (imagePath != null && meatModel.freshmeat != null) {
        userName = meatModel.freshmeat!['userId'] ?? '-';
        if (meatModel.freshmeat!['createdAt'] != null) {
          fetchDate(meatModel.freshmeat!['createdAt']);
          date = '${time.year}.${time.month}.${time.day}';
        }
      }
    } else {
      // 처리육 데이터
      imagePath = meatModel.deepAgedImage;
      if (imagePath != null && meatModel.deepAgedFreshmeat != null) {
        userName = meatModel.deepAgedFreshmeat!["userId"] ?? '-';
        if (meatModel.deepAgedFreshmeat!["createdAt"] != null) {
          fetchDate(meatModel.deepAgedFreshmeat!["createdAt"]);
          date = '${time.year}.${time.month}.${time.day}';
        }
      }
    }

    notifyListeners();
  }

  // 이미지 촬영을 위한 메소드
  Future<void> pickImage() async {
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
      imageFile = File(imagePath!);

      _setInfo();
    }

    isLoading = false; // 로딩 비활성화
    notifyListeners();
  }

  void deleteImage() {
    imagePath = null;
    imageFile = null;
    date = '-';
    userName = '-';
    notifyListeners();
  }

  late BuildContext _context;
  Future<void> saveMeatData(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    _context = context;
    try {
      if (meatModel.seqno == 0) {
        // 원육
        meatModel.imagePath = imagePath;
        meatModel.freshmeat ??= {};
        meatModel.freshmeat!['userId'] = meatModel.userId;
        if (meatModel.id == null) {
          // 등록
        } else {
          // 수정

          await _sendImageToFirebase();
          await RemoteDataSource.sendMeatData(
              'sensory_eval', meatModel.toJsonFresh(null));
        }
      } else {
        // 처리육
        meatModel.deepAgedImage = imagePath;
        meatModel.deepAgedFreshmeat ??= {};
        meatModel.deepAgedFreshmeat!['userId'] = meatModel.userId;
        await _sendImageToFirebase();
        await RemoteDataSource.sendMeatData(
            'sensory_eval',
            meatModel.toJsonFresh({
              "date": meatModel.deepAgingData![meatModel.seqno! - 1]["date"],
              "minute": meatModel.deepAgingData![meatModel.seqno! - 1]["minute"]
            }));
      }
      _movePage();
    } catch (e) {
      print('에러발생: $e');
    }

    isLoading = false;

    notifyListeners();
  }

  void _movePage() {
    if (meatModel.seqno == 0) {
      // 원육
      if (meatModel.id == null) {
        //등록
        _context.go('/home/registration');
      } else {
        // 수정
        _context.go('/home/data-manage-normal/edit');
      }
    } else {
      // 처리육
      _context.go('/home/data-manage-researcher/add/processed-meat');
    }
  }

  // 이미지를 파이어베이스에 저장
  Future<void> _sendImageToFirebase() async {
    try {
      // fire storage에 육류 이미지 저장
      final refMeatImage = FirebaseStorage.instance
          .ref()
          .child('sensory_evals/${meatModel.id}-${meatModel.seqno}.png');

      if (imagePath!.contains('http')) {
        // db 사진
        final http.Response response =
            await http.get(Uri.parse(meatModel.imagePath!));
        final Uint8List imageData = Uint8List.fromList(response.bodyBytes);
        await refMeatImage.putData(
          imageData,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        // 기기 사진
        await refMeatImage.putFile(
          imageFile!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
      }
    } catch (e) {
      print(e);
      // 에러 페이지
      throw Error();
    }
  }
}
