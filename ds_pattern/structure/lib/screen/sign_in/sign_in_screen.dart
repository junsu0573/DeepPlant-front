import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/main_text_field.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/sign_in/sign_in_view_model.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: context.read<SignInViewModel>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.modulate),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 111.w,
                        ),
                      ),
                      Text(
                        '딥에이징',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 68.h,
                      ),
                      // 아이디 입력 필드
                      MainTextField(
                        validateFunc:
                            context.read<SignInViewModel>().idValidate,
                        onSaveFunc: (value) {
                          context.read<SignInViewModel>().userId = value!;
                        },
                        onChangeFunc: (value) {
                          context.read<SignInViewModel>().userId = value!;
                        },
                        mainText: '아이디',
                        hintText: '아이디를 확인하세요',
                        width: 540.w,
                        height: 85.w,
                        isCenter: true,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      // 비밀번호 입력 필드
                      MainTextField(
                        validateFunc:
                            context.read<SignInViewModel>().pwValidate,
                        mainText: '비밀번호',
                        hintText: '비밀번호를 입력하세요.',
                        width: 540.w,
                        height: 85.h,
                        onSaveFunc: (value) {
                          context.read<SignInViewModel>().userPw = value!;
                        },
                        onChangeFunc: (value) {
                          context.read<SignInViewModel>().userPw = value!;
                        },
                        isCenter: true,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      // 로그인 버튼
                      RoundButton(
                        text: Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPress: () async => await context
                            .read<SignInViewModel>()
                            .clickedSignInButton(context),
                        width: 372.w,
                        height: 85.h,
                        bgColor: Palette.mainButtonColor,
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      // 자동로그인 체크박스
                      Row(
                        children: [
                          SizedBox(
                            width: 90.w,
                          ),
                          SizedBox(
                            width: 32.w,
                            height: 32.h,
                            child: Checkbox(
                              value:
                                  context.read<SignInViewModel>().isAutoLogin,
                              onChanged: (value) {
                                context.read<SignInViewModel>().isAutoLogin =
                                    value!;
                              },
                              side: BorderSide(
                                color: Palette.mainButtonColor,
                                width: 1.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Text(
                            '자동 로그인',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                              color: Palette.greyTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      // 회원가입 텍스트버튼
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.go('/sign-in/sign-up');
                        },
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: // 데이터를 처리하는 동안 로딩 위젯 보여주기
                  context.watch<SignInViewModel>().isLoading
                      ? const CircularProgressIndicator()
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
