import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataCellIconButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? fgColor;
  final IconData? icon;
  DataCellIconButton(
      {super.key,
      required this.text,
      required this.onPress,
      required this.width,
      required this.height,
      required this.bgColor,
      required this.fgColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: fgColor,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
            side: BorderSide(color: Colors.black, width: 0.5),
          ),
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w500),
        ),
        icon: Icon(
          icon,
          size: 25.h,
        ),
      ),
    );
  }
}
