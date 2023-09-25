import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PartEval extends StatelessWidget {
  const PartEval({
    super.key,
    required this.value,
    required this.selectedText,
    required this.onChanged,
  });

  final List<String>? selectedText;
  final double value;
  final Function(dynamic value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 60.w),
          child: Row(
            children: [
              Text(
                selectedText![0],
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                selectedText![1],
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Palette.greyTextColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                width: 106.w,
                height: 106.h,
                margin: EdgeInsets.symmetric(horizontal: 8.5.w),
                decoration: BoxDecoration(
                  color: [
                    const Color(0xFFEFEFEF),
                    const Color(0xFFD9D9D9),
                    const Color(0xFFB0B0B0),
                    const Color(0xFF6F6F6F),
                    const Color(0xFF363636),
                  ][i],
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 2; i < 7; i++)
              SizedBox(
                width: 123.w,
                child: Text(
                  selectedText![i],
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        Container(
          width: 640.w,
          height: 50.h,
          margin: EdgeInsets.only(top: 8.h, right: 60.w),
          child: SfSlider(
            min: 0.0,
            max: 9,
            value: value,
            interval: 1,
            showTicks: true,
            showLabels: true,
            activeColor: Palette.mainButtonColor,
            inactiveColor: Palette.subButtonColor,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
