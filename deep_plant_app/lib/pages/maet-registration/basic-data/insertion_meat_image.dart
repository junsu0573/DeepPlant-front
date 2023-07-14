import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
<<<<<<< HEAD
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
=======
>>>>>>> 28e37de (object data edit)
import 'package:deep_plant_app/widgets/camera_page_dialog_custom.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InsertionMeatImage extends StatefulWidget {
  final MeatData meatData;
  final UserModel user;
  const InsertionMeatImage({
    super.key,
    required this.meatData,
    required this.user,
  });

  @override
  State<InsertionMeatImage> createState() => _InsertionMeatImageState();
}

class _InsertionMeatImageState extends State<InsertionMeatImage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  File? pickedImage;
  String? imagePath;
  String? userName;
  bool isLoading = false;
  bool isFinal = false;
  bool isImageAssigned = false;
  late DateTime now;
  String year = '';
  String month = '';
  String day = '';

  // user 정보 가져오기
  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        userName = loggedUser!.displayName;
      }
    } catch (e) {
      print(e);
    }
  }

  // 이미지 촬영을 위한 메소드
  void _pickImage() async {
    final imagePicker = ImagePicker();

    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    setState(() {
      isLoading = true; // 로딩 활성화

      if (pickedImageFile != null) {
        // pickedImage에 촬영한 이미지를 달아놓는다.
        imagePath = pickedImageFile.path;
        pickedImage = File(pickedImageFile.path);
        now = DateTime.now();
        year = now.year.toString();
        month = now.month.toString();
        day = now.day.toString();
        isImageAssigned = true;
      }
    });

    setState(() {
      isLoading = false; // 로딩 비활성화
    });
  }

  // 이미지를 firebase storage에 저장하는 비동기 함수
  Future<void> saveImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      // 이미지를 firbaseStorage에 userid/시간.png 형식으로 저장

      // 이미지 이름 생성!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      final refImage = FirebaseStorage.instance.ref().child('1-2-3-4-5.png');

      await refImage.putFile(
        File(imagePath!),
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void saveData(MeatData meatData, String? imagePath, String year, String month,
      String day) {
    meatData.imageFile = imagePath;
    meatData.saveTime = '{$year}-{$month}-{$day}';
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: Column(
        children: [
          Text(
            '육류 단면 촬영',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    showFirst(context);
                  });
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.grey[600],
                  size: 45.w,
                ),
              ),
              SizedBox(
                width: 40.w,
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 69.w,
              ),
              Text(
                '촬영날짜',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Palette.greyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: isImageAssigned
                      ? Palette.deepOptionColor
                      : Palette.lightOptionColor,
                ),
                width: 158.w,
                height: 73.h,
                child: Text(
                  isImageAssigned ? '$month월' : '월',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 17.w,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: isImageAssigned
                      ? Palette.deepOptionColor
                      : Palette.lightOptionColor,
                ),
                width: 158.w,
                height: 73.h,
                child: Text(
                  isImageAssigned ? '$day일' : '일',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 17.w,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: isImageAssigned
                      ? Palette.deepOptionColor
                      : Palette.lightOptionColor,
                ),
                width: 238.w,
                height: 73.h,
                child: Text(
                  isImageAssigned ? year : '년도',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 69.w,
              ),
              Text(
                '촬영자',
                style: TextStyle(
                  color: Palette.greyTextColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 19.w,
              ),
              isImageAssigned
                  ? Text(
                      '${widget.user.name}(${widget.user.email})',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      '-',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
            ],
          ),
          SizedBox(
            height: 27.h,
          ),
          Stack(
            children: [
              SizedBox(
                width: 585.w,
                height: 585.h,
                child: pickedImage != null
                    ? Image.file(
                        pickedImage!,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(
                        width: 585.w,
                        height: 585.h,
                        child: ElevatedButton(
                          onPressed: () {
                            _pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Palette.textFieldColor,
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 80.0,
                            color: Palette.lightOptionColor,
                          ),
                        ),
                      ),
              ),
              if (pickedImage != null)
                Positioned(
                  top: 10,
                  right: 40,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        pickedImage = null;
                        isImageAssigned = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.black87,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          isLoading ? const CircularProgressIndicator() : Container(),
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 28.h),
            child: SaveButton(
                onPressed: pickedImage != null
                    ? () {
                        saveMeatData();
                        if (!mounted) return;
                        context.go('/option/show-step');
                      }
                    : null,
                text: '다음',
                width: 658.w,
                heigh: 104.h,
                isWhite: false),
          ),
        ],
      ),
    );
  }
}
