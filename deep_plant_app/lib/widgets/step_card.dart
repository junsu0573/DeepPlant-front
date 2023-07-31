import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepCard extends StatelessWidget {
  final String mainText;
  final String subText;
  final String step;
  final bool isCompleted;
  final bool isBefore;
  StepCard({
    super.key,
    required this.mainText,
    required this.subText,
    required this.step,
    required this.isCompleted,
    required this.isBefore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      width: 588.w,
      height: 149.h,
      decoration: BoxDecoration(
        color: (isCompleted || isBefore) ? Color(0xFFE1E1E1) : Colors.white,
        border: Border.all(
          color: Color(0xFFE1E1E1),
          width: 3.sp,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            spreadRadius: 0,
            blurRadius: 10.sp,
            offset: Offset(0, 2.sp),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 32.w,
            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
            child: Center(
              child: Text(
                'STEP\n$step',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 35.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainText,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                isCompleted ? '완료' : subText,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(56, 56, 56, 1),
                ),
              ),
            ],
          ),
          Spacer(),
          Image.asset(
            'assets/images/arrow-r.png',
            width: 48.w,
            height: 48.h,
          ),
        ],
      ),
    );
  }
}
