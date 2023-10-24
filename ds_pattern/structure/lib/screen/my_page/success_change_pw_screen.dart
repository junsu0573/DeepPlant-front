import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/components/main_button.dart';

class SuccessChangePWScreen extends StatelessWidget {
  const SuccessChangePWScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호가 변경되었습니다.',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 18.h),
            child: MainButton(
              onPressed: () => context.go('/home/my-page/user-detail'),
              text: '확인',
              width: 658.w,
              heigh: 104.h,
              isWhite: false,
            ),
          )
        ],
      ),
    );
  }
}
