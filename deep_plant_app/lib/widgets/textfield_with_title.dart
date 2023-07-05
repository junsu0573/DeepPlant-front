import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWithTitle extends StatelessWidget {
  late final String firstText;
  late final String secondText;
  final String? unit;
  final TextEditingController controller;

  TextFieldWithTitle({
    super.key,
    required this.firstText,
    required this.secondText,
    this.unit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(60.w, 0, 0, 112.h),
      child: SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 278.w,
              child: Text(
                firstText,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 36.sp,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(
              width: 259.w,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFDFDFDF), width: 5.w),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 11.w,
            ),
            unit != null
                ? Text(
                    unit!,
                    style: TextStyle(
                      color: Color(0xFF686868),
                      fontSize: 32.sp,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
