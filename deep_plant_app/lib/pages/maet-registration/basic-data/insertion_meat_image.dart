import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/show_error_page.dart';
import 'package:deep_plant_app/source/firebase_services.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/camera_page_dialog_custom.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class InsertionMeatImage extends StatefulWidget {
  final MeatData meatData;
  final UserData userData;
  final int imageIdx;
  const InsertionMeatImage({
    super.key,
    required this.meatData,
    required this.userData,
    required this.imageIdx,
  });

  @override
  State<InsertionMeatImage> createState() => _InsertionMeatImageState();
}

class _InsertionMeatImageState extends State<InsertionMeatImage> {
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

  @override
  void initState() {
    super.initState();
    fetchImage();
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

  void fetchImage() {
    if (widget.imageIdx == 0 && widget.meatData.imagePath != null) {
      imagePath = widget.meatData.imagePath;
      pickedImage = File(imagePath!);
    } else if (widget.imageIdx == 1 && widget.meatData.heatedImage != null) {
      imagePath = widget.meatData.heatedImage;
      pickedImage = File(imagePath!);
    } else if (widget.imageIdx == 2 && widget.meatData.deepAgedImage != null) {
      imagePath = widget.meatData.deepAgedImage;
      pickedImage = File(imagePath!);
    }
  }

  Future<void> saveMeatData() async {
    if (widget.imageIdx == 0) {
      // 원육 사진
      widget.meatData.imagePath = imagePath;
    } else if (widget.imageIdx == 1) {
      // 가열육 사진
      widget.meatData.heatedImage = imagePath;
      dynamic response = await FirebaseServices.sendImageToFirebase(imagePath!,
          'heatedmeat_sensory_evals/${widget.meatData.id}-${widget.meatData.seqno}');
      if (response == null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowError(),
          ),
        );
      }
    } else if (widget.imageIdx == 2) {
      // 처리육 사진
      widget.meatData.deepAgedImage = imagePath;

      dynamic response = await FirebaseServices.sendImageToFirebase(imagePath!,
          'sensory_evals/${widget.meatData.id}-${widget.meatData.seqno}');
      if (response == null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowError(),
          ),
        );
      }
    } else {
      print('imageIdx 에러');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
        closeButtonOnPressed: () {
          showExitDialog(context, null);
        },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 69.h,
                child: IconButton(
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
              ),
              SizedBox(
                width: 40.w,
              ),
            ],
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
                      '${widget.userData.name}(${widget.userData.userId})',
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
                height: 615.h,
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
                  right: 10,
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
                    ? () async {
                        await saveMeatData();
                        if (!mounted) return;
                        Navigator.pop(context);
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
