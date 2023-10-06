import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableListCard extends StatelessWidget {
  final List<String>? sourceCells;
  const TableListCard({super.key, this.sourceCells});

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
              SizedBox(
                width: 300.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    sourceCells![2],
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 80.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    sourceCells![1],
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 165.w,
                height: 55.h,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.black,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  label: Text(
                    (sourceCells![4] == '대기중')
                        ? '대기'
                        : (sourceCells![4] == '승인')
                            ? '승인'
                            : (sourceCells![4] == '반려')
                                ? '반려'
                                : '',
                    style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  icon: Icon(
                    sourceCells![4] == '승인'
                        ? Icons.check_circle_outline_rounded
                        : sourceCells![4] == '반려'
                            ? Icons.close_rounded
                            : sourceCells![4] == '대기중'
                                ? Icons.circle_outlined
                                : null,
                    size: 25.h,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 18.h), height: 0, child: Divider()),
        ],
      ),
    );
  }
}
