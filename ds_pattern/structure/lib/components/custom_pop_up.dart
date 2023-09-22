import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String unselectedText = '선택되지 않은 항목이 있습니다.';
String fileUploadFailedText = '파일 업로드 실패';
String tempSaveText = '임시저장이 완료되었습니다.';
String duplicateEmailText = '중복된 이메일입니다.';
String lateEditText = '작성후 3일이 경과되었습니다.';
String succeedEditText = '이미 승인된 데이터 입니다.';
String failureEditText = '이 데이터는 반려되었습니다!';

void showUnselectedPopup(BuildContext context) {
  // 선택되지않은_popup
  showPopup(context, unselectedText);
}

void showFileUploadFailPopup(BuildContext context) {
  // 실패_popup
  showPopup(context, fileUploadFailedText);
}

void showTemporarySavePopup(BuildContext context) {
  // 임시저장_popup
  showPopup(context, tempSaveText);
}

void showDuplicateEmailPopup(BuildContext context) {
  // 이메일 중복
  showPopup(context, duplicateEmailText);
}

void showDataManageLatePopup(BuildContext context) {
  // 3일 경과
  showPopup(context, lateEditText);
}

void showDataManageSucceedPopup(BuildContext context) {
  // 승인 데이터
  showPopup(context, succeedEditText);
}

void showDataManageFailurePopup(BuildContext context) {
  // 반려 데이터
  showPopup(context, failureEditText);
}

void showPopup(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Container(
                width: 646.w,
                height: 263.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/close.png',
                    width: 48.w,
                    height: 48.h,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      });
}
