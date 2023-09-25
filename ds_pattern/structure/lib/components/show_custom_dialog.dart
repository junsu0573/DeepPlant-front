import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showDeletePhotoDialog(BuildContext context, VoidCallback? rightFunc) {
  showCustomDialog(context, 'assets/images/trash.png', '사진을 삭제할까요?', '삭제된 사진은 복구할 수 없습니다.', '취소', '삭제', null, () {
    rightFunc;
  });
}

void showExitDialog(BuildContext context, VoidCallback? rightFunc) {
  showCustomDialog(context, 'assets/images/exit.png', '데이터가 저장되지 않았습니다', '창을 닫을 시 정보가 모두 삭제됩니다.', '취소', '나가기', null, () {
    rightFunc;
    Navigator.pop(context);
    Navigator.pop(context);
  });
}

void showDataRegisterDialog(
  BuildContext context,
  VoidCallback? leftFunc,
  VoidCallback? rightFunc,
) {
  showCustomDialog(
    context,
    'assets/images/data_register.png',
    '임시저장 중인 데이터 등록이 있습니다.',
    '이어서 등록하시겠습니까?',
    '처음부터 등록하기',
    '이어서 등록하기',
    leftFunc,
    rightFunc,
  );
}

void showFreshmeatEvaluationDialog(BuildContext context) {
  showCustomDialog(
    context,
    'assets/images/Trash.png',
    '신선육 관능평가를 하시겠습니까?',
    '',
    '아니요',
    '네',
    null,
    () {
      /*  평가 기능  */
    },
  );
}

void showTemporarySaveDialog(
  BuildContext context,
  VoidCallback? rightFunc,
) {
  showCustomDialog(
    context,
    'assets/images/exit.png',
    '임시저장 하시겠습니까?',
    '',
    '아니요',
    '네',
    null,
    rightFunc,
  );
}

// 다이얼로그 형식입니다.
void showCustomDialog(
  BuildContext context,
  String iconPath,
  String titleText,
  String contentText,
  String leftButtonText,
  String rightButtonText,
  VoidCallback? leftButtonFunc,
  VoidCallback? rightButtonFunc,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 461.h,
          width: 646.w,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
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
                    DialogButton(
                      buttonFunc: leftButtonFunc ??
                          () {
                            Navigator.pop(context);
                          },
                      buttonText: leftButtonText,
                    ),
                    SizedBox(
                      width: 41.w,
                    ),
                    DialogButton(
                      buttonFunc: rightButtonFunc,
                      buttonText: rightButtonText,
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

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.buttonFunc,
    required this.buttonText,
  });

  final VoidCallback? buttonFunc;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonFunc,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
            side: BorderSide(color: Color(0xFFD9D9D9), width: 2.w),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(Size(230.w, 104.h)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.sp,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
