import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataTableGuide extends StatelessWidget {
  const DataTableGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(top: 18.h),
      height: 75.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.w,
              ),
              SizedBox(
                width: 210.w,
                child: Text(
                  '관리번호',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 100.w,
                child: Text(
                  '작성자',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 100.w,
                child: Text(
                  '승인여부',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 25.w,
              )
            ],
          ),
          Container(margin: EdgeInsets.only(top: 18.h), height: 0, child: Divider()),
        ],
      ),
    );
  }
}
