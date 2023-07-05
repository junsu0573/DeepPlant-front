import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final double heigh;
  final bool isWhite;

  const SaveButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.width,
    required this.heigh,
    required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isWhite
          ? BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(19.sp),
            )
          : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Color(0xFFC4C4C4),
          backgroundColor: isWhite ? Colors.white : Color(0xFF515151),
          minimumSize: Size(width, heigh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.sp),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isWhite ? Color.fromRGBO(55, 55, 55, 1) : Colors.white,
            fontSize: 30.sp,
            fontFamily: 'Inter',
            height: (50 / 30).h,
          ),
        ),
      ),
    );
  }
}
