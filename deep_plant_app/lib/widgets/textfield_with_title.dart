import 'package:deep_plant_app/source/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWithTitle extends StatelessWidget {
  late final String firstText;
  late final String secondText;
  final String? unit;
  final TextEditingController controller;
  final bool? isPercent;

  TextFieldWithTitle({
    super.key,
    required this.firstText,
    required this.secondText,
    this.unit,
    required this.controller,
    this.isPercent,
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
              child: Row(
                children: [
                  Text(
                    firstText,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 36.sp,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    secondText,
                    style: TextStyle(
                      color: Palette.greyTextColor,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 259.w,
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller,
                inputFormatters: isPercent != null && isPercent == true
                    ? [
                        _PercentageInputFormatter(),
                      ]
                    : [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^-?\d{0,8}(\.\d{0,4})?')),
                      ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5.w),
                  ),
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

class _PercentageInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    double parsedValue = double.tryParse(newValue.text) ?? 0.0;

    if (parsedValue < 0 || parsedValue > 100 || newValue.text.length > 7) {
      // 입력이 0부터 100 사이의 퍼센트 값이 아닌 경우, 입력을 무시합니다.
      return oldValue;
    }

    return newValue;
  }
}
