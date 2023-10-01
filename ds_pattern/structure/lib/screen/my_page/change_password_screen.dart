import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/main_text_field.dart';
import 'package:structure/viewModel/my_page/change_password_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: context.read<ChangePasswordViewModel>().formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 62.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '기존 비밀번호',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MainTextField(
                        validateFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .pwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .onChangedOriginPW(value),
                        mainText: '',
                        hintText: '',
                        width: 600.w,
                        height: 30,
                        isObscure: true,
                        isCenter: true,
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Text(
                        '변경할 비밀번호',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MainTextField(
                        validateFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .newPwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .onChangedNewPw(value),
                        mainText: '영문 대/소문자+숫자+특수문자',
                        hintText: '',
                        width: 600.w,
                        height: 30,
                        isObscure: true,
                        isCenter: false,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.w),
                        child: Text(
                          '영문 대/소문자, 숫자, 특수문자로 10자리 이상 구성해주세요.',
                          style: TextStyle(
                            color: context
                                    .watch<ChangePasswordViewModel>()
                                    .isRedTextPw
                                ? Colors.red
                                : const Color.fromRGBO(183, 183, 183, 1),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      MainTextField(
                        validateFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .cPwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) => context
                            .read<ChangePasswordViewModel>()
                            .onChangedCPw(value),
                        mainText: '비밀번호 확인',
                        hintText: '',
                        width: 600.w,
                        height: 30,
                        isObscure: true,
                        isCenter: false,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 32.w),
                        child: Text(
                          '비밀번호가 일치하지 않습니다.',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: context
                                    .watch<ChangePasswordViewModel>()
                                    .isRedTextCPw
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 500.h,
              ),
              MainButton(
                onPressed: context.watch<ChangePasswordViewModel>().completed
                    ? () async {}
                    : null,
                text: '저장',
                width: 658.w,
                heigh: 89.h,
                isWhite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
