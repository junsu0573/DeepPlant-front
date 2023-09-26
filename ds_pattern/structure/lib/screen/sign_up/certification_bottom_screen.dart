import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/sign_up/certification_bottom_view_model.dart';

class CertificationBottomScreen extends StatefulWidget {
  const CertificationBottomScreen({
    super.key,
  });

  @override
  State<CertificationBottomScreen> createState() =>
      _CertificationBottomScreenState();
}

class _CertificationBottomScreenState extends State<CertificationBottomScreen> {
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
                      value: context
                          .read<CertificationBottomViewModel>()
                          .isChecked1,
                      onChanged: (value) => context
                          .read<CertificationBottomViewModel>()
                          .clicked1stCheckBox(value),
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
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Palette.greyTextColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: context
                          .read<CertificationBottomViewModel>()
                          .isChecked2,
                      onChanged: (value) => context
                          .read<CertificationBottomViewModel>()
                          .clicked2ndCheckBox(value),
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
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '보기',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Palette.greyTextColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: context
                          .read<CertificationBottomViewModel>()
                          .isChecked3,
                      onChanged: (value) => context
                          .read<CertificationBottomViewModel>()
                          .clicked3rdCheckBox(value),
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
                const Divider(),
                Row(
                  children: [
                    Checkbox(
                      value: context
                          .read<CertificationBottomViewModel>()
                          .isChecked4,
                      onChanged: (value) => context
                          .read<CertificationBottomViewModel>()
                          .clicked4thCheckBox(value),
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
            MainButton(
              onPressed:
                  context.read<CertificationBottomViewModel>().isRequiredChecked
                      ? () => context
                          .read<CertificationBottomViewModel>()
                          .clickedNextBotton()
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
