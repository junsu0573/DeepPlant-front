import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InsertionIdnPw extends StatefulWidget {
  final UserModel? user;
  const InsertionIdnPw({
    super.key,
    required this.user,
  });

  @override
  State<InsertionIdnPw> createState() => _InsertionIdnPwState();
}

class _InsertionIdnPwState extends State<InsertionIdnPw> {
  final _formKey = GlobalKey<FormState>(); // form 구성

  List<String> dropdownList = ['사용자 1', '사용자 2', '사용자 3'];
  String selectedDropdown = '사용자 1';
  String userLevel = 'users_1';

  String _userEmail = '';
  String _userPw = '';

  String? userCompany;
  String? userPosition;
  String? userCompanyAdress;

  bool _isLoading = false;

  // firbase authentic
  final _authentication = FirebaseAuth.instance;

  // 아이디 유효성 검사
  String? idValidate(String? value) {
    if (value!.isEmpty || !value.contains('@') || !value.contains('.')) {
      return '이메일을 확인하세요.';
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

  // 비밀번호 재입력 유효성 검사
  String? cPwValidate(String? value) {
    if (value!.isEmpty || value != _userPw) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      signUpWithVerify();
    }
  }

  Color buttonColor = const Color.fromRGBO(51, 51, 51, 1).withOpacity(0.5);

  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();
  TextEditingController textFieldController4 = TextEditingController();

  // 필수 입력 항목들이 입력됐는지 확인하는 함수
  void checkTextFieldValues() {
    if (textFieldController1.text.isNotEmpty &&
        textFieldController2.text.isNotEmpty &&
        textFieldController3.text.isNotEmpty &&
        textFieldController4.text.isNotEmpty) {
      setState(() {
        buttonColor = Theme.of(context).primaryColor;
      });
    } else {
      setState(() {
        buttonColor = Theme.of(context).primaryColor.withOpacity(0.5);
      });
    }
  }

  // user의 정보를 저장하는 함수
  void saveUserData(bool isVerified) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(userLevel);

    // 데이터 생성
    Map<String, dynamic> data = {
      'name': widget.user!.name,
      'email': widget.user!.email,
      'isAlarmed': widget.user!.isAlarmed,
      'isVerified': isVerified,
    };

    // 데이터 저장
    DocumentReference document = users.doc(widget.user!.email);
    await document.set(data);
  }

  // 회원가입 및 인증
  Future<void> signUpWithVerify() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // 새로운 유저 생성
      UserCredential credential = await _authentication
          .createUserWithEmailAndPassword(email: _userEmail, password: _userPw);
      // 이메일 인증 보내기
      await credential.user!.sendEmailVerification();
      // 사용자의 정보를 firestore에 저장
      saveUserData(credential.user!.emailVerified);
      // 페이지 이동
      context.go('/sign-in/certification/insert-id-pw/email-verification');
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          print('이메일 중복');
          break;
        case 'invalid-email':
          print('올바르지 않은 이메일');
          break;
        default:
          print('Error');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    textFieldController1.dispose();
    textFieldController2.dispose();
    textFieldController3.dispose();
    textFieldController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '아이디/비밀번호',
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
          FocusScope.of(context).unfocus(); // 키보드 unfocus
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('*이름'),
                      ),
                      // 이름 입력 필드
                      TextInsertionField(
                        validateFunc: null,
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          checkTextFieldValues();
                          widget.user!.name = value;
                        },
                        mainText: '이름',
                        hintText: '이름을 입력하세요.',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                        controller: textFieldController1,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('*이메일'),
                      ),
                      TextInsertionField(
                        validateFunc: idValidate,
                        onSaveFunc: (value) {
                          _userEmail = value!;
                        },
                        onChangeFunc: (value) {
                          checkTextFieldValues();
                          widget.user!.email = value;
                        },
                        mainText: 'example@example.com',
                        hintText: '',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                        controller: textFieldController2,
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('*비밀번호'),
                      ),
                      // 비밀번호 입력 필드
                      TextInsertionField(
                        validateFunc: pwValidate,
                        onSaveFunc: (value) {
                          _userPw = value!;
                        },
                        onChangeFunc: (value) {
                          checkTextFieldValues();
                          _userPw = value!;
                        },
                        mainText: '영문+숫자+특수문자',
                        hintText: '',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                        controller: textFieldController3,
                      ),
                      // 비밀번호 재입력 필드
                      TextInsertionField(
                        validateFunc: cPwValidate,
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          checkTextFieldValues();
                        },
                        mainText: '비밀번호 확인',
                        hintText: '',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                        controller: textFieldController4,
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('권한'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // dropdown 버튼
                          Container(
                            width: 350,
                            height: 48,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            child: DropdownButton(
                              padding: const EdgeInsets.only(left: 40),
                              value: selectedDropdown,
                              items: dropdownList.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          item,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                if (value == dropdownList[0]) {
                                  userLevel = 'users_1';
                                } else if (value == dropdownList[1]) {
                                  userLevel = 'users_2';
                                } else {
                                  userLevel = 'users_3';
                                }
                              },
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(30),
                              underline: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.transparent, width: 0)),
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('소속'),
                      ),

                      // 회사명 입력 필드
                      TextInsertionField(
                        validateFunc: null,
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          userCompany = value;
                        },
                        mainText: '회사명 입력',
                        hintText: '',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                      ),

                      // 직책 입력 필드
                      TextInsertionField(
                        validateFunc: null,
                        onSaveFunc: null,
                        onChangeFunc: (value) {
                          userPosition = value;
                        },
                        mainText: '직책 입력',
                        hintText: '',
                        width: 0,
                        isObscure: false,
                        isCenter: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 회사주소 입력 필드
                          Container(
                            width: 250,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            child: TextFormField(
                              onChanged: (value) {
                                userCompanyAdress = value;
                              },
                              decoration: InputDecoration(
                                  label: const Text('회사주소 검색'),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: null, // 입력 필드 오른쪽에 표시될 아이콘
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16)),
                            ),
                          ),
                          CommonButton(
                            text: '검색',
                            onPress: () {},
                            width: 100,
                            height: 45,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: buttonColor == Theme.of(context).primaryColor
                      ? () async {
                          _tryValidation();

                          // context.go(
                          //     '/sign-in/certification/insert-id-pw/succeed-sign-up');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              _isLoading ? const CircularProgressIndicator() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
