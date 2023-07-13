import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final double heigh;
  final bool isWhite;
  final Color? color;

  const SaveButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.width,
    required this.heigh,
    required this.isWhite,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigh,
      decoration: isWhite
          ? BoxDecoration(
              border: Border.all(color: Color.fromRGBO(121, 121, 121, 1)),
              borderRadius: BorderRadius.circular(19.sp),
            )
          : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Color(0xFFC4C4C4),
          backgroundColor: isWhite ? Colors.white : color ?? Color(0xFF515151),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.sp),
          ),
          elevation: 0,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isWhite ? Color.fromRGBO(55, 55, 55, 1) : Colors.white,
              fontSize: 30.sp,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
