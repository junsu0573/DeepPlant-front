import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyPage extends StatefulWidget {
  final UserData userData;
  const MyPage({
    super.key,
    required this.userData,
  });

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void _signOut(BuildContext context) async {
    try {
      // 파이어베이스 로그아웃
      await FirebaseAuth.instance.signOut();

      // 로그아웃 API 호출
      final response = await ApiServices.signOut(widget.userData.userId!);
      if (response == null) {
        throw Error();
      }

      // home 화면으로 이동
      if (!mounted) return;
      context.go('/');
    } catch (e) {
      print('로그아웃 에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          CustomAppBar(title: '마이페이지', backButton: true, closeButton: false),
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
            SizedBox(
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
                        color: Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '권한',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '가입날짜',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Color.fromRGBO(124, 124, 124, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      '${widget.userData.name}',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '${widget.userData.userId}',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '${widget.userData.type}',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Text(
                      '${widget.userData.createdAt}',
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
                CommonButton(
                  text: Text(
                    '수정',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  onPress: () => context.go('/option/my-page/edit-info'),
                  width: 139.w,
                  height: 49.h,
                  bgColor: Color.fromRGBO(217, 217, 217, 1),
                ),
                SizedBox(
                  width: 70.w,
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () => _signOut(context),
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
