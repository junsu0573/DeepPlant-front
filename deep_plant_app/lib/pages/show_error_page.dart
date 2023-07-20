import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShowError extends StatelessWidget {
  const ShowError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('에러가 발생했습니다.'),
            ),
          ),
          SaveButton(
            onPressed: () => context.pop(),
            text: '홈으로',
            width: 658.w,
            heigh: 104.h,
            isWhite: false,
          ),
        ],
      ),
    );
  }
}
