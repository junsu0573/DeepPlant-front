import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepCard extends StatelessWidget {
  final String mainText;
  final String subText;
  final String step;
  final bool isCompleted;
  StepCard({
    super.key,
    required this.mainText,
    required this.subText,
    required this.step,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(3),
      width: 588.w,
      height: 159.h,
      decoration: BoxDecoration(
        color: isCompleted ? Color(0xFFE1E1E1) : Colors.white,
        border: Border.all(
          color: Color(0xFFE1E1E1),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromRGBO(217, 217, 217, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'STEP',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                Text(
                  step,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mainText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              isCompleted ? Text('완료') : Text(subText),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
