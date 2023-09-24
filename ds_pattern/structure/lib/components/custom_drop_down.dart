import 'package:structure/config/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final Widget hintText;
  final String? value;
  final List<String> itemList;
  final Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.value,
    required this.itemList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42.5.sp),
        border: Border.all(
          color: Pallete.mainTextFieldColor,
          width: 1.0,
        ),
      ),
      child: DropdownButton(
        padding: EdgeInsets.only(left: 64.w),
        alignment: Alignment.center,
        elevation: 1,
        underline: Container(),
        borderRadius: BorderRadius.circular(42.5.sp),
        dropdownColor: Colors.white,
        menuMaxHeight: 310.h,
        icon: Container(
          width: 34.w,
          margin: EdgeInsets.only(right: 30.w),
          child: Image.asset('assets/images/arrow-b.png'),
        ),
        isExpanded: true,
        hint: hintText,
        value: value,
        iconDisabledColor: Colors.transparent,
        items: itemList
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Center(
                      child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
