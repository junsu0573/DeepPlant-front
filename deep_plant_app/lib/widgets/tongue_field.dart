import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TongueFiled extends StatelessWidget {
  final String mainText;
  final String subText;
  @override
  const TongueFiled({
    super.key,
    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 60.w),
      child: Row(
        children: [
          Text(
            mainText,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            subText,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(96, 96, 96, 1),
            ),
          ),
          Spacer(),
          SizedBox(
            width: 318.w,
            height: 50.h,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.w),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDFDFDF), width: 5.w),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
