import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';

class DeepAgingCard extends StatelessWidget {
  final String deepAgingNum;
  final int minute;
  final String butcheryDate;
  final bool completed;
  final bool isLast;
  final VoidCallback onTap;
  final VoidCallback? delete;
  const DeepAgingCard({
    super.key,
    required this.deepAgingNum,
    required this.minute,
    required this.butcheryDate,
    required this.completed,
    required this.isLast,
    required this.onTap,
    this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
          ),
          height: 70.0,
          child: OutlinedButton(
            onPressed: onTap,
            child: Row(
              children: [
                SizedBox(
                  width: 52.w,
                  child: Center(
                    child: Text(
                      deepAgingNum,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 54.w,
                  child: VerticalDivider(
                    thickness: 2,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  width: 128.w,
                  child: Text(
                    '$minute',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 186.w,
                  child: Text(
                    butcheryDate,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    completed ? '완료' : '미완료',
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
        isLast == true
            ? Positioned(
                top: -5.h,
                right: -10.w,
                child: IconButton(
                  onPressed: delete,
                  icon: Icon(
                    Icons.delete,
                    size: 30.sp,
                    color: Palette.greyTextColor,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
