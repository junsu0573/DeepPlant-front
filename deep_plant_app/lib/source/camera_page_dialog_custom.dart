import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showFirst(BuildContext context) {
  showCustomDialog(context, 'assets/images/trash.png', '카메라와 육류의 일정 거리를\n 유지합니다.', null, () {
    context.pop();
    showSecond(context);
  });
}

void showSecond(BuildContext context) {
  showCustomDialog(context, 'assets/images/exit.png', '데이터가 저장되지 않았습니다', () {
    context.pop();
    showFirst(context);
  }, () {
    context.pop();
    showThird(context);
  });
}

void showThird(BuildContext context) {
  showCustomDialog(context, 'assets/images/picture_save.png', '사진을 저장하시겠습니까 ?', () {
    context.pop();
    showSecond(context);
  }, () {
    context.pop();
    showFourth(context);
  });
}

void showFourth(BuildContext context) {
  showCustomDialog(context, 'assets/images/data_register.png', '진행중인 데이터 등록이 있습니다.', () {
    context.pop();
    showThird(context);
  }, () {
    context.pop();
    showfifth(context);
  });
}

void showfifth(BuildContext context) {
  showCustomDialog(context, 'assets/images/trash.png', '신선육 관능평가를 하시겠습니까?', () {
    context.pop();
    showFourth(context);
  }, null);
}

// 다이얼로그 형식입니다.
void showCustomDialog(
  BuildContext context,
  String iconPath,
  String contentText,
  VoidCallback? leftButtonFunc,
  VoidCallback? rightButtonFunc,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '촬영 메뉴얼',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36.sp,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close,
                size: 30,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              contentText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36.sp,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: leftButtonFunc,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      side: BorderSide(color: Colors.white, width: 2.w),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(15.w, 12.h)),
                ),
                child: Icon(
                  Icons.arrow_left_rounded,
                  color: Colors.grey[400],
                  size: 45.0,
                ),
              ),
              SizedBox(
                width: 65.w,
              ),
              TextButton(
                onPressed: rightButtonFunc,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      side: BorderSide(color: Colors.white, width: 2.w),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(Size(15.w, 12.h)),
                ),
                child: Icon(
                  Icons.arrow_right_rounded,
                  color: Colors.grey[400],
                  size: 45.0,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
