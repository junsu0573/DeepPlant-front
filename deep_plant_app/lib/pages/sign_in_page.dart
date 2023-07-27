import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';

import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  const SignIn({
    required this.userData,
    required this.meatData,
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // form key
  final _formKey = GlobalKey<FormState>();

  String _userId = '';
  String _userPw = '';

  bool isLoading = false;
  bool? _isAutoLogin = false;

  // firbase authentic
  final _authentication = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    widget.userData.resetData();
  }

  // 아이디 유효성 검사
  String? idValidate(String? value) {
    if (value!.isEmpty || !value.contains('@') || !value.contains('.')) {
      return '아이디를 확인하세요.';
    }
    return null;
  }

  // 비밀번호 유효성 검사
  String? pwValidate(String? value) {
    if (value!.isEmpty || value.length < 10) {
      return '비밀번호를 확인하세요.';
    }
    return null;
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  // 데이터 호출 및 저장
  Future<void> signIn() async {
    // 로딩 상태를 활성화
    setState(() {
      isLoading = true;
    });

    try {
      // 유저의 이메일이 valid 해야 로그인 진행
      await _authentication.signInWithEmailAndPassword(
        email: _userId,
        password: _userPw,
      );
      final bool isValidEmail = await getUserValid();
      if (!isValidEmail) {
        _authentication.signOut();

        throw InvalidEmailException('이메일 인증을 완료하세요.');
      }

      // 유저 정보 저장
      await saveUserInfo();
    } catch (e) {
      // 로딩 상태를 비활성화
      setState(() {
        isLoading = false;
      });

      // 예외 처리
      String errorMessage;
      if (e is FirebaseException) {
        // 로그인 실패
        errorMessage = '아이디와 비밀번호를 확인하세요.';
      } else if (e is InvalidEmailException) {
        // 이메일 인증 미완료
        errorMessage = e.message;
      } else {
        // 기타 오류
        errorMessage = '오류가 발생했습니다.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.amber,
        ),
      );

      return;
    }
  }

  // 유저의 이메일 valid 검사
  Future<bool> getUserValid() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.reload();
      if (user.emailVerified) {
        return true;
      }
    } catch (e) {
      print('인증 실패');
    }
    return false;
  }

  // 유저 정보 저장
  Future<void> saveUserInfo() async {
    // 로그인 API 호출
    dynamic userInfo = await ApiServices.signIn(_userId);
    if (userInfo == null) {
      // 에러 메시지 호출
      setState(() {
        isLoading = false;
      });
      return;
    }

    // 데이터 fetch
    if (userInfo != null) {
      widget.userData.fetchData(userInfo);
    }

    // 로딩 상태를 비활성화
    setState(() {
      isLoading = false;
    });

    // 데이터 fetch 성공시 다음 페이지로 go
    if (!mounted) return;
    context.go('/option');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 unfocus
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                      TextInsertionField(
                        validateFunc: idValidate,
                        onSaveFunc: (value) {
                          _userId = value!;
                        },
                        onChangeFunc: (value) {
                          _userId = value!;
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
                      TextInsertionField(
                        validateFunc: pwValidate,
                        mainText: '비밀번호',
                        hintText: '비밀번호를 입력하세요.',
                        width: 540.w,
                        height: 85.h,
                        onSaveFunc: (value) {
                          _userPw = value!;
                        },
                        onChangeFunc: (value) {
                          _userPw = value!;
                        },
                        isCenter: true,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      // 로그인 버튼
                      CommonButton(
                        text: Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPress: () {
                          _tryValidation();
                          signIn();
                        },
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
                              value: _isAutoLogin,
                              onChanged: (value) {
                                setState(() {
                                  _isAutoLogin = value;
                                });
                              },
                              side: BorderSide(
                                color: Palette.greyTextColor,
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
                          // 회원가입 페이지를 push
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
                  isLoading ? const CircularProgressIndicator() : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

// 이메일 인증 예외 처리
class InvalidEmailException implements Exception {
  final String message;

  InvalidEmailException(this.message);

  @override
  String toString() {
    return 'InvalidEmailException: $message';
  }
}
