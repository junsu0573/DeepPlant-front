import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataAddHome extends StatefulWidget {
  const DataAddHome({super.key});

  @override
  State<DataAddHome> createState() => _DataAddHomeState();
}

class _DataAddHomeState extends State<DataAddHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'EUWD2830aeaE',
        backButton: false,
        closeButton: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 65.w),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '원육',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.w,
            ),
            Divider(
              height: 0,
            ),
            SizedBox(
              height: 23.w,
            ),
            Row(
              children: [
                Text(
                  '생성자ID',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  'example@example.com',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: Palette.greyTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.w,
            ),
            Container(
              width: 588.w,
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              decoration: BoxDecoration(
                color: Palette.textFieldColor,
              ),
              child: Row(
                children: [
                  Text('종'),
                  Spacer(),
                  Text('부위'),
                  Spacer(),
                  Text('도축일자'),
                  Spacer(),
                  Text('추가정보 입력'),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Row(
              children: [
                Text(
                  '처리육',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                Text(
                  '딥에이징 데이터',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  '엑셀파일 업로드',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 588.w,
              height: 36.h,
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              decoration: BoxDecoration(color: Palette.textFieldColor),
              child: Row(
                children: [
                  Text('차수'),
                  Spacer(),
                  Text('처리시간'),
                  Spacer(),
                  Text('처리일자'),
                  Spacer(),
                  Text('추가정보 입력'),
                ],
              ),
            ),
            Text('card'),
            Text('card'),
            Text('추가하기'),
            Text('총처리횟수/총처리시간'),
          ],
        ),
      ),
    );
  }
}
