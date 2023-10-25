import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/meat_registration/registration_meat_image_view_model.dart';

class RegistrationMeatImageScreen extends StatelessWidget {
  const RegistrationMeatImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '육류 단면 촬영',
        backButton: false,
        closeButton: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('촬영 날짜'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 315.w,
                        height: 78.h,
                        decoration: BoxDecoration(
                          color: Palette.mainTextFieldColor,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(context.watch<RegistrationMeatImageViewModel>().date),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('촬영자'),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 315.w,
                        height: 78.h,
                        decoration: BoxDecoration(
                          color: Palette.mainTextFieldColor,
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(context.watch<RegistrationMeatImageViewModel>().userName),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '단면 촬영 사진',
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  context.watch<RegistrationMeatImageViewModel>().imagePath != null
                      ? Stack(
                          children: [
                            SizedBox(
                              width: 640.w,
                              height: 653.h,
                              child: context.watch<RegistrationMeatImageViewModel>().imagePath != null &&
                                      context.watch<RegistrationMeatImageViewModel>().imagePath!.contains('http')
                                  ? Image.network(
                                      context.read<RegistrationMeatImageViewModel>().imagePath!,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                : null,
                                          );
                                        }
                                      },
                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    )
                                  : Image.file(
                                      File(context.read<RegistrationMeatImageViewModel>().imagePath!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              right: 15.h,
                              top: 15.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.h),
                                  color: Colors.black,
                                ),
                                child: IconButton(
                                    onPressed: () => context.read<RegistrationMeatImageViewModel>().deleteImage(),
                                    iconSize: 55.h,
                                    icon: const Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        )
                      : InkWell(
                          onTap: () => context.read<RegistrationMeatImageViewModel>().pickImage(),
                          child: DottedBorder(
                            color: Palette.greyTextColor,
                            strokeWidth: 2.sp,
                            dashPattern: [10.w, 10.w],
                            child: SizedBox(
                              width: 640.w,
                              height: 653.h,
                              child: Icon(
                                Icons.add_circle,
                                color: Palette.greyTextColor,
                                size: 82.w,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 40.h),
                child: MainButton(
                  onPressed: context.watch<RegistrationMeatImageViewModel>().imagePath != null
                      ? () async => await context.read<RegistrationMeatImageViewModel>().saveMeatData(context)
                      : null,
                  text: context.read<RegistrationMeatImageViewModel>().meatModel.id == null ? '완료' : "수정사항 저장",
                  width: 640.w,
                  heigh: 96.h,
                  isWhite: false,
                ),
              ),
            ],
          ),
          context.watch<RegistrationMeatImageViewModel>().isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
