import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void ShowDeletePhotoDialog(BuildContext context) {
  showCustomDialog(context, 'assets/images/trash.png', '사진을 삭제하시겠습니까 ?',
      '삭제된 사진은 복구할 수 없습니다.', '취소', '삭제', () {}, () {/*   삭제 기능  */});
}

void ShowExitDialog(BuildContext context) {
  showCustomDialog(context, 'assets/images/exit.png', '데이터가 저장되지 않았습니다',
      '창을 닫을 시 정보가 모두 삭제됩니다.', '취소', '나가기', () {}, () {/*  나가기 기능  */});
}

void ShowSavePhotoDialog(BuildContext context) {
  showCustomDialog(context, 'assets/images/picture_save.png', '사진을 저장하시겠습니까 ?',
      '저장한 사진은 수정할 수 없습니다.', '취소', '확인', () {}, () {/*  확인 기능  */});
}

void ShowDataRegisterDialog(BuildContext context) {
  showCustomDialog(
      context,
      'assets/data_register.png',
      '진행중인 데이터 등록이 있습니다.',
      '이어서 등록하시겠습니까 ?',
      '처음부터',
      '이어서 등록', () {/*  처음부터 기능  */}, () {/*  이어서 등록 기능  */});
}

void ShowFreshmeatEvaluationDialog(BuildContext context) {
  showCustomDialog(context, 'assets/images/Trash.png', '신선육 관능평가를 하시겠습니까?', '',
      '아니요', '네', () {}, () {
    /*  평가 기능  */
  });
}

void ShowTemporarySaveDialog(BuildContext context) {
  showCustomDialog(
      context, 'assets/images/exit.png', '임시저장하시겠습니까?', '', '아니요', '네', () {},
      () {
    /* 임시 저장 기능  */
  });
}

// 다이얼로그 형식입니다.
void showCustomDialog(
  BuildContext context,
  String iconPath,
  String titleText,
  String contentText,
  String LeftButtonText,
  String RightButtonText,
  VoidCallback? LeftButtonFunc,
  VoidCallback? RightButtonFunc,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 461.h,
          width: 646.w,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 96.h,
                  width: 96.w,
                  child: Image.asset(
                    iconPath,
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  titleText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(contentText),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: LeftButtonFunc,
                      child: Text(
                        LeftButtonText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontFamily: 'Inter',
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            side: BorderSide(
                                color: Color(0xFFD9D9D9), width: 2.w),
                          ),
                        ),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(230.w, 104.h)),
                      ),
                    ),
                    SizedBox(
                      width: 41.w,
                    ),
                    TextButton(
                      onPressed: RightButtonFunc,
                      child: Text(
                        RightButtonText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.sp,
                          fontFamily: 'Inter',
                        ),
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                            side: BorderSide(
                                color: Color(0xFFD9D9D9), width: 2.w),
                          ),
                        ),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(230.w, 104.h)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
