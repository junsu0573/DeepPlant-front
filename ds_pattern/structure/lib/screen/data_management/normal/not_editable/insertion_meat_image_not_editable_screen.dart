import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/insertion_meat_image_not_editable_view_model.dart';

class InsertionMeatImageNotEditableScreen extends StatelessWidget {
  const InsertionMeatImageNotEditableScreen({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('촬영 날짜'),
                      Container(
                        width: 315.w,
                        height: 88.h,
                        decoration:
                            const BoxDecoration(color: Palette.subButtonColor),
                        alignment: Alignment.centerLeft,
                        child: Text(context
                            .watch<InsertionMeatImageNotEditableViewModel>()
                            .date),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('촬영자'),
                      Container(
                        width: 315.w,
                        height: 88.h,
                        decoration:
                            const BoxDecoration(color: Palette.subButtonColor),
                        alignment: Alignment.centerLeft,
                        child: Text(context
                            .watch<InsertionMeatImageNotEditableViewModel>()
                            .userName),
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
                    width: 640.w,
                    height: 473.h,
                    child: Image.network(
                      context
                          .read<InsertionMeatImageNotEditableViewModel>()
                          .imagePath!,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          context.watch<InsertionMeatImageNotEditableViewModel>().isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
