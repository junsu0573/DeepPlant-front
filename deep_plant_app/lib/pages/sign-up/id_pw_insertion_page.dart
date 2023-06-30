import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/pages/sign-up/certification_bottom_sheet.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_popup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdPwInsertion extends StatefulWidget {
  const IdPwInsertion({super.key});

  @override
  State<IdPwInsertion> createState() => _IdPwInsertionState();
}

class _IdPwInsertionState extends State<IdPwInsertion> {
  // form 구성
  final _formKey = GlobalKey<FormState>();

  // firebase firestore
  final _firestore = FirebaseFirestore.instance;

  bool _isUnique = false;
  String userEmail = '';
  String userPassword = '';
  String userCPassword = '';

  // 버튼 활성화 확인을 위한 변수
  bool _isValidId = false;
  bool _isValidPw = false;
  bool isValidCPw = false;

  // validation 문구를 위한 변수
  bool isRedTextId = false;
  bool isRedTextPw = false;
  bool isRedTextCPw = false;

  // 아이디 유효성 검사
  String? idValidate(String? value) {
    final bool isValid = EmailValidator.validate(value!);
    if (value.isEmpty) {
      setState(() {
        _isValidId = false;
        isRedTextId = false;
      });
      return null;
    } else if (!isValid) {
      setState(() {
        _isValidId = false;
        isRedTextId = true;
      });
      return null;
    }

    setState(() {
      _isValidId = true;
      isRedTextId = false;
    });

    return null;
  }

  // 비밀번호 유효성 검사
  String? pwValidate(String? value) {
    final bool isValid = validatePassword(value!);
    if (value.isEmpty) {
      setState(() {
        _isValidPw = false;
        isRedTextPw = false;
      });
      return null;
    } else if (!isValid) {
      setState(() {
        _isValidPw = false;
        isRedTextPw = true;
      });
      return null;
    }

    setState(() {
      _isValidPw = true;
      isRedTextPw = false;
    });

    return null;
  }

  // 비밀번호 재입력 유효성 검사
  String? cPwValidate(String? value) {
    if (value!.isEmpty) {
      setState(() {
        isValidCPw = false;
        isRedTextCPw = false;
      });
      return null;
    } else if (userPassword != userCPassword) {
      setState(() {
        isValidCPw = false;
        isRedTextCPw = true;
      });
      return null;
    }

    setState(() {
      isValidCPw = true;
      isRedTextCPw = false;
    });

    return null;
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  bool validatePassword(String password) {
    // 비밀번호 유효성을 검사하는 정규식
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\-_=+{};:,<.>]).{10,}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(password);
  }

  Future<void> dupliCheck(String userEmail) async {
    try {
      // 유저가 입력한 ID가 해당 컬렉션에 존재하는지 확인
      DocumentSnapshot docSnapshot =
          await _firestore.collection('user_emails').doc(userEmail).get();

      if (docSnapshot.exists) {
        setState(() {
          _isUnique = false;
          if (_isValidId) {
            showDuplicateEmailPopup(context);
          }
        });
      } else {
        if (_isValidId) {
          setState(() {
            _isUnique = true;
          });
        }
      }
    } catch (e) {
      print('에러 발생');
    }
  }

  // 모든 값이 올바르게 입력됐는지 확인
  bool isAllChecked() {
    if (_isValidId && _isValidPw && _isValidPw && _isUnique) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backButton: true,
        closeButton: false,
        title: '아이디/패스워드',
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                              decoration: InputDecoration(
                                hintText: '이메일',
                              ),
                              onSaved: (value) {
                                userEmail = value!;
                              },
                              onChanged: (value) {
                                setState(() {
                                  userEmail = value;
                                  _isUnique = false;
                                  _tryValidation();
                                });
                              },
                              validator: (value) => idValidate(value),
                            ),
                          ),
                          Spacer(),
                          CommonButton(
                              text: _isUnique
                                  ? Icon(Icons.check)
                                  : Text(
                                      '중복확인',
                                      style: TextStyle(fontSize: 30.sp),
                                    ),
                              onPress: _isUnique
                                  ? null
                                  : () => dupliCheck(userEmail),
                              width: 169.w,
                              height: 75.h),
                        ],
                      ),
                      Text(
                        '잘못된 이메일 형식입니다.',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: isRedTextId ? Colors.red : Colors.white,
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
                          decoration: InputDecoration(
                            hintText: '영문 대/소문자+숫자+특수문자',
                          ),
                          onSaved: (value) {
                            userPassword = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              userPassword = value;
                              _tryValidation();
                            });
                          },
                          validator: (value) => pwValidate(value),
                        ),
                      ),
                      Text(
                        '영문,숫자,특수문자를 모두 포함해 10자 이상으로 구성해주세요.',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: isRedTextPw
                                ? Colors.red
                                : Color.fromRGBO(183, 183, 183, 1)),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 540.w,
                        // 패스워드 재입력 필드
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: '패스워드 확인',
                          ),
                          onSaved: (value) {
                            userCPassword = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              userCPassword = value;
                              _tryValidation();
                            });
                          },
                          validator: (value) => cPwValidate(value),
                        ),
                      ),
                      Text(
                        '비밀번호가 일치하지 않습니다.',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: isRedTextCPw ? Colors.red : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 470.h,
                      ),
                    ],
                  ),
                ),
                SaveButton(
                  onPressed: isAllChecked()
                      ? () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => CertificationBottomSheet(),
                          );
                        }
                      : null,
                  text: '다음',
                  width: 658.w,
                  heigh: 104.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 약관동의 창
void _certificationSheet(BuildContext context) {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
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
                      onChanged: null,
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
                      onChanged: null,
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
                      onChanged: null,
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
                        isChecked4 = value!;
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
            SaveButton(text: '다음', width: 658.w, heigh: 104.h),
          ],
        ),
      ),
    ),
  );
}
