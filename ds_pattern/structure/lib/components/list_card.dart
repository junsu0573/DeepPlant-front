import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';

class ListCard extends StatelessWidget {
  final VoidCallback? onTap;
  final int idx;
  final String num;
  final String dayTime;
  final String statusType;
  final int dDay;
  const ListCard({
    super.key,
    required this.onTap,
    required this.idx,
    required this.num,
    required this.dayTime,
    required this.statusType,
    required this.dDay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 640.w,
        height: 72.w,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Palette.greyTextColor, width: 1.sp),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Text(num),
            const Spacer(),
            Text(dayTime),
            const Spacer(),
            Text(statusType),
            statusType == "대기중"
                ? Stack(
                    children: [
                      Icon(
                        Icons.edit_note,
                        color: dDay >= 0 ? Colors.black : Palette.disabledButtonColor,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 36.w,
                          height: 16.h,
                          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(28.5.sp))),
                          alignment: Alignment.center,
                          child: Text(
                            'D-$dDay',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      )
                    ],
                  )
                : Icon(
                    Icons.edit_note,
                    color: dDay <= 3 && statusType == '대기중' ? Colors.black : Palette.disabledButtonColor,
                  ),
            SizedBox(
              width: 10.w,
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
