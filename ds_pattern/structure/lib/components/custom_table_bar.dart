import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTableBar extends StatelessWidget {
  const CustomTableBar({super.key, required this.isNormal});
  final bool isNormal;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.only(top: 18.h),
      height: 70.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
              ),
              SizedBox(
                width: 180.w,
                child: Text(
                  '관리번호',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 80.w,
                child: Text(
                  isNormal ? '날짜' : '작성자',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100.w,
                child: Text(
                  '관리',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
              )
            ],
          ),
          Container(margin: EdgeInsets.only(top: 18.h), height: 0, child: const Divider()),
        ],
      ),
    );
  }
}
