import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/sign-up/certification_bottom_sheet.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_popup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class IdPwInsertion extends StatefulWidget {
  UserData userData;
  IdPwInsertion({
    super.key,
    required this.userData,
  });

  @override
  State<IdPwInsertion> createState() => _IdPwInsertionState();
}

class _IdPwInsertionState extends State<IdPwInsertion> {
  // form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // user 정보 초기화
    widget.userData.resetData();
  }

  bool _isUnique = false;
  String userName = '';
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
    // 비어있지 않고 이메일 형식에 맞지 않을 때, 빨간 예외 메시지
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
    // 비어있지 않고 비밀번호 형식에 맞지 않을 때, 빨간 에러 메시지
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
    // 비어있지 않고 비밀번호와 같지 않을 때, 빨간 에러 메시지
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

  // 비밀번호 유효성 검사 (정규식)
  bool validatePassword(String password) {
    // 조건: 영문 대/소문자, 숫자, 특수문자 10자~15자
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\-_=+{};:,<.>]).{10,15}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(password);
  }

  // 이메일 중복 검사
  Future<void> dupliCheck(String userEmail) async {
    try {
      // 유저 정보 검색
      dynamic data = await ApiServices.signIn(userEmail);

      if (data == null) {
        // 해당 유저 정보 없음
        setState(() {
          _isUnique = true;
        });
      } else {
        // 이메일 중복
        setState(() {
          _isUnique = false;
          showDuplicateEmailPopup(context);
        });
      }
    } catch (e) {
      print('에러 발생');
    }
  }

  // 모든 값이 올바르게 입력됐는지 확인
  bool isAllChecked() {
    if (_isValidId &&
        _isValidPw &&
        _isValidPw &&
        _isUnique &&
        userName.isNotEmpty) {
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
                      SizedBox(
                        width: 540.w,
                        // 이름 입력 필드
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: '이름',
                          ),
                          onSaved: (value) {
                            userName = value!;
                          },
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
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
                          // 중복확인 버튼
                          CommonButton(
                              text: _isUnique
                                  ? Icon(Icons.check)
                                  : Text(
                                      '중복확인',
                                      style: TextStyle(fontSize: 30.sp),
                                    ),
                              onPress: _isUnique
                                  ? null
                                  : () =>
                                      _isValidId ? dupliCheck(userEmail) : {},
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
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300.h,
                ),
                SaveButton(
                  onPressed: isAllChecked()
                      ? () {
                          // user의 이메일, 패스워드, 이름을 객체에 저장
                          widget.userData.userId = userEmail;
                          widget.userData.password = userPassword;
                          widget.userData.name = userName;

                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => CertificationBottomSheet(
                              userData: widget.userData,
                            ),
                          );
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
        ),
      ),
    );
  }
}
