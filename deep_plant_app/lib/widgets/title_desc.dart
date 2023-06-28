import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleDesc extends StatelessWidget {
  final String title;
  final String desc;

  const TitleDesc({
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60.h,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36.sp,
                fontFamily: 'Inter',
                height: 1.389.h,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          height: 50.h,
          child: Center(
            child: Text(
              desc,
              style: TextStyle(
                color: Color(0xFF606060),
                fontSize: 24.sp,
                fontFamily: 'Inter',
                height: 1.667.h, // line-height equivalent
              ),
            ),
          ),
        ),
      ],
    );
  }
}
