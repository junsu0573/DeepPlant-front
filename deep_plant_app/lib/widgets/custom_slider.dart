import 'package:deep_plant_app/source/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final Function(dynamic)? onChanged;
  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 648.w,
      height: 50.h,
      margin: EdgeInsets.only(top: 8.h, right: 54.h),
      child: SfSlider(
        min: 0.0,
        max: 9,
        value: widget.value,
        interval: 1,
        showTicks: true,
        showLabels: true,
        activeColor: Palette.mainButtonColor,
        inactiveColor: Palette.subButtonColor,
        enableTooltip: true,
        minorTicksPerInterval: 1,
        onChanged: widget.onChanged,
        //(dynamic value) {
        //   setState(() {
        //     _value = double.parse(value.toStringAsFixed(1));
        //   });
        // },
      ),
    );
  }
}
