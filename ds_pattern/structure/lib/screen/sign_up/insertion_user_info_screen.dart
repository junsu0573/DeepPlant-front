import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/viewModel/insertion_user_info_view_model.dart';

class InsertionUserInfoScreen extends StatefulWidget {
  const InsertionUserInfoScreen({super.key});

  @override
  State<InsertionUserInfoScreen> createState() =>
      _InsertionUserInfoScreenState();
}

class _InsertionUserInfoScreenState extends State<InsertionUserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        backButton: true,
        closeButton: false,
        title: '아이디/패스워드',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: context.read<InsertionUserInfoViewModel>().formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 540.w,
                        // 이름 입력 필드
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: '이름',
                          ),
                          onSaved: (value) {
                            context
                                .read<InsertionUserInfoViewModel>()
                                .userName = value!;
                          },
                          onChanged: (value) {
                            context
                                .read<InsertionUserInfoViewModel>()
                                .userName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        '아이디',
                        style: TextStyle(fontSize: 30.sp),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 368.w,
                            // 이메일 입력 필드
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                hintText: '이메일',
                              ),
                              onSaved: (value) {
                                context
                                    .read<InsertionUserInfoViewModel>()
                                    .userEmail = value!;
                              },
                              onChanged: (value) => context
                                  .read<InsertionUserInfoViewModel>()
                                  .insertedEmail(value),
                              validator: (value) => context
                                  .read<InsertionUserInfoViewModel>()
                                  .idValidate(value),
                            ),
                          ),
                          const Spacer(),

                          // 중복확인 버튼
                          RoundButton(
                              text: context
                                      .read<InsertionUserInfoViewModel>()
                                      .isUnique
                                  ? const Icon(Icons.check)
                                  : Text(
                                      '중복확인',
                                      style: TextStyle(fontSize: 27.sp),
                                    ),
                              onPress: context
                                      .read<InsertionUserInfoViewModel>()
                                      .isUnique
                                  ? null
                                  : () => context
                                          .read<InsertionUserInfoViewModel>()
                                          .isValidId
                                      ? context
                                          .read<InsertionUserInfoViewModel>()
                                          .dupliCheck(context)
                                      : null,
                              width: 169.w,
                              height: 75.h),
                        ],
                      ),
                      Text(
                        '잘못된 이메일 형식입니다.',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: context
                                  .read<InsertionUserInfoViewModel>()
                                  .isRedTextId
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        '패스워드',
                        style: TextStyle(fontSize: 30.sp),
                      ),
                      SizedBox(
                        width: 540.w,
                        // 패스워드 입력 필드
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: '영문 대/소문자+숫자+특수문자',
                          ),
                          onSaved: (value) {
                            context
                                .read<InsertionUserInfoViewModel>()
                                .userPassword = value!;
                          },
                          onChanged: (value) => context
                              .read<InsertionUserInfoViewModel>()
                              .insertedPw(value),
                          validator: (value) => context
                              .read<InsertionUserInfoViewModel>()
                              .pwValidate(value),
                        ),
                      ),
                      Text(
                        '영문,숫자,특수문자를 모두 포함해 10자 이상으로 구성해주세요.',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: context
                                    .read<InsertionUserInfoViewModel>()
                                    .isRedTextPw
                                ? Colors.red
                                : const Color.fromRGBO(183, 183, 183, 1)),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 540.w,
                        // 패스워드 재입력 필드
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: '패스워드 확인',
                          ),
                          onSaved: (value) {
                            context
                                .read<InsertionUserInfoViewModel>()
                                .userCPassword = value!;
                          },
                          onChanged: (value) => context
                              .read<InsertionUserInfoViewModel>()
                              .insertedCPw(value),
                          validator: (value) => context
                              .read<InsertionUserInfoViewModel>()
                              .cPwValidate(value),
                        ),
                      ),
                      Text(
                        '비밀번호가 일치하지 않습니다.',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: context
                                  .read<InsertionUserInfoViewModel>()
                                  .isRedTextCPw
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300.h,
                ),
                MainButton(
                  onPressed:
                      context.read<InsertionUserInfoViewModel>().isAllChecked()
                          ? () => context
                              .read<InsertionUserInfoViewModel>()
                              .clickedNextButton(context)
                          : null,
                  text: '다음',
                  width: 658.w,
                  heigh: 104.h,
                  isWhite: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
