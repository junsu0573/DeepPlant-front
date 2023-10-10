import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_icon_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
                image: const AssetImage('assets/images/person.png'),
                onTap: () =>
                    context.read<HomeViewModel>().clickedMyPage(context),
                width: 63.w,
                height: 63.h,
              ),
              SizedBox(
                width: 25.w,
              )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
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
                InkWell(
                  onTap: () =>
                      context.read<HomeViewModel>().clickedMeatRegist(context),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 494.w,
                          height: 240.h,
                          decoration: BoxDecoration(
                            color: Palette.subButtonColor,
                            borderRadius: BorderRadius.circular(20.sp),
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
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                    textAlign: TextAlign.end,
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
                InkWell(
                  onTap: () =>
                      context.read<HomeViewModel>().clickedDataManage(context),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: 494.w,
                          height: 240.h,
                          decoration: BoxDecoration(
                            color: Palette.mainButtonColor,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                    textAlign: TextAlign.end,
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
