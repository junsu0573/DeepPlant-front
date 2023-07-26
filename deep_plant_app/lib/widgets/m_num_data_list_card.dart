import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MNumDataListCard extends StatelessWidget {
  final int idx;
  final String mNum;
  final bool? noButton;
  final VoidCallback? buttonAction;
  const MNumDataListCard({
    super.key,
    required this.idx,
    required this.mNum,
    this.noButton,
    this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
              ),
              Text(
                '$idx',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 292.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    mNum,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Spacer(),
              noButton == null
                  ? CommonButton(
                      text: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20.5.w,
                          ),
                          Text(
                            ' 추가',
                            style: TextStyle(fontSize: 30.sp),
                          ),
                        ],
                      ),
                      onPress: buttonAction,
                      width: 151.w,
                      height: 63.h,
                      bgColor: Color.fromRGBO(178, 178, 178, 1),
                    )
                  : SizedBox(
                      width: 0.w,
                    ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 18.h), height: 0, child: Divider()),
        ],
      ),
    );
  }
}
