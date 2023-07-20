import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CertificationBottomSheet extends StatefulWidget {
  final UserData userData;
  const CertificationBottomSheet({
    super.key,
    required this.userData,
  });

  @override
  State<CertificationBottomSheet> createState() =>
      _CertificationBottomSheetState();
}

class _CertificationBottomSheetState extends State<CertificationBottomSheet> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  bool isRequiredChecked = false;

  bool _checkCheckBoxValues() {
    if (isChecked1 == true && isChecked2 == true && isChecked3 == true) {
      isChecked4 = true;
    } else {
      isChecked4 = false;
    }
    if (isChecked1 == true && isChecked2 == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.67,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.sp)),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(60.w, 44.h, 60.w, 0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '약관동의',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  '간단한 약관동의 후 회원가입이 진행됩니다.',
                  style:
                      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 81.h,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked1,
                      onChanged: (value) {
                        setState(() {
                          isChecked1 = value!;
                          isRequiredChecked = _checkCheckBoxValues();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '개인정보 수집제공 동의(필수)',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Palette.lightOptionColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked2,
                      onChanged: (value) {
                        setState(() {
                          isChecked2 = value!;
                          isRequiredChecked = _checkCheckBoxValues();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '제 3자 정보제공 동의 (필수)',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Palette.lightOptionColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked3,
                      onChanged: (value) {
                        setState(() {
                          isChecked3 = value!;
                          isRequiredChecked = _checkCheckBoxValues();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '알림받기 (선택)',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked4,
                      onChanged: (value) {
                        setState(() {
                          isChecked1 = value!;
                          isChecked2 = value;
                          isChecked3 = value;
                          isChecked4 = value;
                          isRequiredChecked = _checkCheckBoxValues();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Text(
                      '모두 확인 및 동의합니다.',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 57.h,
            ),
            SaveButton(
              onPressed: isRequiredChecked
                  ? () {
                      widget.userData.alarm = isChecked3;
                      context.go('/sign-in/sign-up/add-user-info');
                    }
                  : null,
              text: '다음',
              width: 658.w,
              heigh: 104.h,
              isWhite: false,
            ),
          ],
        ),
      ),
    );
  }
}
