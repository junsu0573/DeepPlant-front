import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/viewModel/my_page/user_info_view_model.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
          title: '마이페이지', backButton: true, closeButton: false),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 84.h,
            ),
            Image.asset(
              'assets/images/person.png',
              width: 151.w,
              height: 151.h,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '권한',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '가입날짜',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      context.read<UserInfoViewModel>().userName,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      context.read<UserInfoViewModel>().userId,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      context.read<UserInfoViewModel>().userType,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      context.read<UserInfoViewModel>().createdAt,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 54.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundButton(
                  text: Text(
                    '수정',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  onPress: () =>
                      context.read<UserInfoViewModel>().clickedEdit(context),
                  width: 139.w,
                  height: 49.h,
                  bgColor: const Color.fromRGBO(217, 217, 217, 1),
                ),
                SizedBox(
                  width: 70.w,
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () async =>
                  context.read<UserInfoViewModel>().clickedSignOut(context),
              child: Text(
                '로그아웃',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 65.sp,
            ),
          ],
        ),
      ),
    );
  }
}
