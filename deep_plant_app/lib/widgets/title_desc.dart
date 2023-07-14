import 'package:deep_plant_app/source/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleDesc extends StatelessWidget {
  final String title;
  final String desc;

  const TitleDesc({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 60.w),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            desc,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: Palette.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
