import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SucceedPwChange extends StatelessWidget {
  const SucceedPwChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Text(
              '비밀번호 변경이 완료되었습니다.',
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SaveButton(
            onPressed: () => context.pop(),
            text: '이전화면',
            width: 658.w,
            heigh: 104.h,
            isWhite: false,
          ),
        ],
      ),
    );
  }
}
