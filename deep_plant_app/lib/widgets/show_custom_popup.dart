import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//////////////////////////////////////////////////////////////////////////////////////
String UnselectedText = '선택되지 않은 항목이 있습니다.';
String FileUploadFailText = '파일 업로드 실패';
String TemporarySaveText = '데이터 등록을 실패했습니다.';

void showUnselectedPopup(BuildContext context) {
  // 선택되지않은_popup
  showPopup(context, UnselectedText);
}

void showFileUploadFailPopup(BuildContext context) {
  // 실패_popup
  showPopup(context, FileUploadFailText);
}

void showTemporarySavePopup(BuildContext context) {
  // 임시저장_popup
  showPopup(context, TemporarySaveText);
}
/////////////////////////////////////////////// ////////////////////////////////////////

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
                    'assets/images/Close.png',
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
