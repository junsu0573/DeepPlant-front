import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/show_custom_dialog.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/insertion_meat_image_view_model.dart';

class InsertionMeatImage extends StatefulWidget {
  const InsertionMeatImage({
    super.key,
  });

  @override
  State<InsertionMeatImage> createState() => _InsertionMeatImageState();
}

class _InsertionMeatImageState extends State<InsertionMeatImage> {
  @override
  void initState() {
    super.initState();
    context.read<InsertionMeatImageViewModel>().fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '육류 단면 촬영',
        backButton: false,
        closeButton: true,
        closeButtonOnPressed: () {
          showExitDialog(context, null);
        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40.w,
                  ),
                  Text(
                    '촬영 날짜',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Palette.greyTextColor,
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                  ),
                  Text(
                    '촬영자',
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
              Consumer<InsertionMeatImageViewModel>(
                builder: (context, viewModel, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Palette.backgroundFieldColor,
                      ),
                      width: 315.w,
                      height: 88.h,
                      child: Text(
                        viewModel.isImageAssigned ? '${viewModel.time.year}.${viewModel.time.month}.${viewModel.time.day}' : '',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Palette.backgroundFieldColor,
                      ),
                      width: 315.w,
                      height: 88.h,
                      child: Text(
                        viewModel.isImageAssigned ? '${viewModel.userModel.name}' : '',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40.w,
                  ),
                  Text(
                    '단면 촬영 사진',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Palette.greyTextColor,
                    ),
                  ),
                ],
              ),
              Consumer<InsertionMeatImageViewModel>(
                builder: (context, viewModel, child) => Stack(
                  children: [
                    SizedBox(
                      width: 585.w,
                      height: 615.h,
                      child: viewModel.pickedImage != null
                          ? Image.file(
                              viewModel.pickedImage!,
                              fit: BoxFit.cover,
                            )
                          : SizedBox(
                              width: 585.w,
                              height: 585.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  viewModel.pickImage();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_circle,
                                  size: 82.0,
                                  color: Color.fromRGBO(215, 215, 215, 1),
                                ),
                              ),
                            ),
                    ),
                    if (viewModel.pickedImage != null)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            // 여기에 다이얼로그 추가해보자!
                            viewModel.pickedImage = null;
                            viewModel.isImageAssigned = false;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: Colors.black,
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
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 28.h),
                child: MainButton(
                    onPressed: context.read<InsertionMeatImageViewModel>().pickedImage != null
                        ? () async {
                            // await saveMeatData();
                            // if (!mounted) return;
                            // Navigator.pop(context);
                          }
                        : null,
                    text: '완료',
                    width: 658.w,
                    heigh: 104.h,
                    isWhite: false),
              ),
            ],
          ),
          if (context.read<InsertionMeatImageViewModel>().isLoading) CircularProgressIndicator()
        ],
      ),
    );
  }
}
