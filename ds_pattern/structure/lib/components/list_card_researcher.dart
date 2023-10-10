import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';

class ListCardResearcher extends StatelessWidget {
  final VoidCallback? onTap;
  final int idx;
  final String num;
  final String createdAt;

  const ListCardResearcher({
    super.key,
    required this.onTap,
    required this.idx,
    required this.num,
    required this.createdAt,
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
            Text('$idx'),
            SizedBox(
              width: 50.w,
            ),
            Text(num),
            const Spacer(),
            Text(createdAt),
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
