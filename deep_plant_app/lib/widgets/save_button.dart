import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 28.sp),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Color(0xFFC4C4C4),
          backgroundColor: Color(0xFF515151),
          minimumSize: Size(658.w, 104.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.sp),
          ),
        ),
        child: Text(
          '저장',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.sp,
            fontFamily: 'Inter',
            height: (50 / 30).h,
          ),
        ),
      ),
    );
  }
}
