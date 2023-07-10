import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditUserInfo extends StatelessWidget {
  final UserModel user;
  const EditUserInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          CustomAppBar(title: '아이디/비밀번호', backButton: true, closeButton: false),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 62.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 85.h,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 232, 232, 1),
                        borderRadius: BorderRadius.circular(42.sp),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32.w,
                          ),
                          Text(
                            '${user.email}',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(153, 153, 153, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Text(
                      '비밀번호',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // 비밀번호 변경 버튼
                    CommonButton(
                      text: Text('비밀번호 변경하기'),
                      onPress: () {
                        context.go('/option/my-page/edit-info/reset-pw');
                      },
                      width: 500,
                      height: 85.h,
                    ),
                    SizedBox(
                      height: 36.h,
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
                            keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                      height: 81.h,
                    ),
                  ],
                ),
              ),
              SaveButton(
                text: '저장',
                width: 658.w,
                heigh: 106.h,
                isWhite: false,
              ),
              SizedBox(
                height: 45.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
