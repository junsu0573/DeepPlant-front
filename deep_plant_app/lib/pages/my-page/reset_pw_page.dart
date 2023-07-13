import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPW extends StatefulWidget {
  const ResetPW({super.key});

  @override
  State<ResetPW> createState() => _ResetPWState();
}

class _ResetPWState extends State<ResetPW> {
  // form 구성
  final _formKey = GlobalKey<FormState>();

  // validation 문구를 위한 변수
  bool isRedTextPw = false;
  bool isRedTextCPw = false;

  String userPassword = '';
  String userNewPassword = '';
  String userCPassword = '';

  // 버튼 활성화 확인을 위한 변수
  bool _isValidPw = false;
  bool _isValidNewPw = false;
  bool _isValidCPw = false;

  // 기존 비밀번호 유효성 검사
  String? pwValidate(String? value) {
    if (value!.isEmpty) {
      _isValidPw = false;
      return null;
    } else if (value != '12341234') {
      _isValidPw = false;
      return '비밀번호를 확인하세요.';
    } else {
      _isValidPw = true;
      return null;
    }
  }

  // 새 비밀번호 유효성 검사
  String? newPwValidate(String? value) {
    final bool isValid = validatePassword(value!);
    if (value.isEmpty) {
      setState(() {
        _isValidNewPw = false;
        isRedTextPw = false;
      });
      return null;
    } else if (!isValid) {
      setState(() {
        _isValidNewPw = false;
        isRedTextPw = true;
      });
      return null;
    }

    setState(() {
      _isValidNewPw = true;
      isRedTextPw = false;
    });

    return null;
  }

  // 비밀번호 재입력 유효성 검사
  String? cPwValidate(String? value) {
    if (value!.isEmpty) {
      setState(() {
        _isValidCPw = false;
        isRedTextCPw = false;
      });
      return null;
    } else if (userNewPassword != userCPassword) {
      setState(() {
        _isValidCPw = false;
        isRedTextCPw = true;
      });
      return null;
    }

    setState(() {
      _isValidCPw = true;
      isRedTextCPw = false;
    });

    return null;
  }

  bool validatePassword(String password) {
    // 비밀번호 유효성을 검사하는 정규식
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\-_=+{};:,<.>]).{10,}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(password);
  }

  // 모든 값이 올바르게 입력됐는지 확인
  bool _isAllValid() {
    if (_isValidPw && _isValidNewPw && _isValidCPw) {
      return true;
    }
    return false;
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  // 비밀번호 변경
  void changePassword(String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        if (!mounted) {
          return;
        }
        context.go('success-pw-change');
      } catch (e) {
        print('error');
      }
    } else {
      print('user does not exist.');
    }
  }

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
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
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
                      TextInsertionField(
                        validateFunc: (value) => pwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          setState(() {
                            userPassword = value!;
                            _tryValidation();
                          });
                        },
                        mainText: '',
                        hintText: '',
                        width: 0,
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
                      TextInsertionField(
                        validateFunc: (value) => newPwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          setState(() {
                            userNewPassword = value!;
                            _tryValidation();
                          });
                        },
                        mainText: '영문 대/소문자+숫자+특수문자',
                        hintText: '',
                        width: 0,
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
                            color: isRedTextPw
                                ? Colors.red
                                : Color.fromRGBO(183, 183, 183, 1),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      TextInsertionField(
                        validateFunc: (value) => cPwValidate(value),
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          userCPassword = value!;
                          _tryValidation();
                        },
                        mainText: '비밀번호 확인',
                        hintText: '',
                        width: 0,
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
                            color: isRedTextCPw ? Colors.red : Colors.white,
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
              SaveButton(
                onPressed: _isAllValid()
                    ? () {
                        changePassword(userNewPassword);
                      }
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
