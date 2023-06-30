import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final double heigh;

  const SaveButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.width,
    required this.heigh,
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
          minimumSize: Size(width, heigh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.sp),
          ),
        ),
        child: Text(
          text,
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
