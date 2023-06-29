import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SignIn extends StatefulWidget {
  final UserModel user;
  final MeatData meatData;
  const SignIn({
    required this.user,
    required this.meatData,
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>(); // form 구성
  String _userId = '';
  String _userPw = '';

  bool isLoading = false;
  bool? _isAutoLogin = false;

  // dropdown 버튼 리스트
  List<String> dropdownList = ['사용자 1', '사용자 2', '사용자 3'];
  String selectedDropdown = '사용자 1';

  // firbase authentic
  final _authentication = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

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

  // 데이터를 가져오는 비동기 함수
  void fetchData() async {
    setState(() {
      isLoading = true; // 로딩 상태를 활성화
    });

    // 유저 등급 설정
    String userLevel = '';
    if (selectedDropdown == '사용자 1') {
      userLevel = 'users_1';
    } else if (selectedDropdown == '사용자 2') {
      userLevel = 'users_2';
    } else if (selectedDropdown == '사용자 3') {
      userLevel = 'users_3';
    }

    // 데이터를 가져오는 비동기 작업
    try {
      await _authentication.signInWithEmailAndPassword(
        email: _userId,
        password: _userPw,
      );

      // 유저가 입력한 ID가 해당 level 컬렉션에 존재하는지 확인
      DocumentSnapshot docSnapshot =
          await _firestore.collection(userLevel).doc(_userId).get();

      if (!docSnapshot.exists) {
        _authentication.signOut();
        throw Error();
      }

      // 유저의 데이터를 객체에 저장
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        widget.user.name = data['name'];
        widget.user.email = _userId;
        widget.meatData.userEmail = _userId;
        widget.user.level = userLevel;
      }

      // 유저의 로그 정보를 fire store에 저장
      DateTime now = DateTime.now();

      String userLog = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

      Map<String, dynamic> updateData = {
        'lastLog': userLog,
      };
      await _firestore.collection(userLevel).doc(_userId).update(updateData);
    } catch (e) {
      // 로딩 상태를 비활성화
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디와 비밀번호를 확인하세요'),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    setState(() {
      isLoading = false; // 로딩 상태를 비활성화
    });

    // 데이터 fetch 성공시 다음 페이지를 push
    if (!mounted) return;
    context.pushReplacement('/option');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 unfocus
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    // 딥플랜트 로고 이미지
                    padding: const EdgeInsets.all(0),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.black, BlendMode.modulate),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 111.w,
                        height: 111.w,
                      ),
                    ),
                  ),
                  const Text(
                    '딥에이징',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(
                    height: 68,
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
                    width: 55,
                    isObscure: false,
                    isCenter: true,
                  ),
                  // 비밀번호 입력 필드
                  TextInsertionField(
                    validateFunc: pwValidate,
                    mainText: '비밀번호',
                    hintText: '비밀번호를 입력하세요.',
                    width: 55,
                    isObscure: true,
                    onSaveFunc: (value) {
                      _userPw = value!;
                    },
                    onChangeFunc: (value) {
                      _userPw = value!;
                    },
                    isCenter: true,
                  ),
                  // 사용자 권한 dropdown 버튼
                  Container(
                    width: 300,
                    height: 50,
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
                        setState(() {
                          selectedDropdown = value;
                        });
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

                  // 회원가입 텍스트버튼
                  TextButton(
                    onPressed: () {
                      // 회원가입 페이지를 push
                      context.go('/sign-in/certification');
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  // 자동로그인 체크박스
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Checkbox(
                        value: _isAutoLogin,
                        onChanged: (value) {
                          setState(() {
                            _isAutoLogin = value;
                          });
                        },
                      ),
                      const Text('자동 로그인'),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  // 확인 버튼
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        _tryValidation();
                        fetchData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // 데이터를 처리하는 동안 로딩 위젯 보여주기
                  isLoading ? const CircularProgressIndicator() : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
