import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 45.h,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              CustomIconButton(
                image: AssetImage('assets/images/person.png'),
                onTap: () {
                  context.go('/option/my-page');
                },
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '딥에이징',
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '육류 맛 선호 예측 시스템',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 38.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 육류 등록 버튼
                GestureDetector(
                  onTap: () {
                    context.go('/option/show-step');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 494.w,
                          height: 240.h,
                          decoration: BoxDecoration(
                            color: Palette.lightOptionColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '육류 등록',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '육류 정보를 입력하고',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  Text(
                                    '데이터를 전송합니다',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 17.h,
                          left: 21.w,
                          child: Image.asset(
                            'assets/images/meat_add.png',
                            width: 121.w,
                            height: 118.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 데이어 관리 버튼
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      context.go('/option/add-data');
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 494.w,
                          height: 240.h,
                          decoration: BoxDecoration(
                            color: Palette.deepOptionColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '데이터 관리',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '등록된 데이터를',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  Text(
                                    '열람/수정합니다',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 36.h,
                          left: 51.w,
                          child: Image.asset(
                            'assets/images/data.png',
                            width: 99.w,
                            height: 99.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
