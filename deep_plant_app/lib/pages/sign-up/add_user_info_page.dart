import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddUserInfo extends StatelessWidget {
  final UserData user;
  const AddUserInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            CustomAppBar(title: '상세정보', backButton: true, closeButton: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 62.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      '주소',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 412.w,
                          height: 50.h,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '주소',
                            ),
                          ),
                        ),
                        Spacer(),
                        CommonButton(
                          text: Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPress: () {},
                          width: 125.w,
                          height: 75.h,
                          bgColor: Color.fromRGBO(46, 48, 62, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '상세주소 (동/호수)',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 68.h,
                    ),
                    Text(
                      '회사정보',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 412.w,
                          height: 50.h,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '주소',
                            ),
                          ),
                        ),
                        Spacer(),
                        CommonButton(
                          text: Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPress: () {},
                          width: 125.w,
                          height: 75.h,
                          bgColor: Color.fromRGBO(46, 48, 62, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '회사명',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 235.w,
                          height: 50.h,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '부서명',
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 235.w,
                          height: 50.h,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '직위',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '전화번호',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 265.h,
                    ),
                  ],
                ),
              ),
              SaveButton(
                onPressed: () => context.go('/sign-in/succeed-sign-up'),
                text: '다음',
                width: 658.w,
                heigh: 106.h,
                isWhite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
