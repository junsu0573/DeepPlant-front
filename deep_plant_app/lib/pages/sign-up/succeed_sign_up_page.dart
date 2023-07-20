import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SucceedSignUp extends StatelessWidget {
  const SucceedSignUp({super.key});

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
                    '회원가입이 완료되었습니다 !',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '이메일 인증을 완료해주세요.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 18.h),
            child: SaveButton(
              onPressed: () => context.go('/sign-in'),
              text: '로그인',
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
