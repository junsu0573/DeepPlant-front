import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdPwInsertion extends StatefulWidget {
  const IdPwInsertion({super.key});

  @override
  State<IdPwInsertion> createState() => _IdPwInsertionState();
}

class _IdPwInsertionState extends State<IdPwInsertion> {
  final _formKey = GlobalKey<FormState>(); // form 구성

  final _firestore = FirebaseFirestore.instance;
  bool _isUnique = false;
  String userEmail = '';

  String? idValidate(String? value) {
    if (value!.isEmpty || !value.contains('@') || !value.contains('.')) {
      return '이메일을 확인하세요.';
    } else {
      dupliCheck(userEmail);
      if (!_isUnique) {
        return '중복된 이메일입니다.';
      }
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

  Future<void> dupliCheck(String userEmail) async {
    try {
      // 유저가 입력한 ID가 해당 컬렉션에 존재하는지 확인
      DocumentSnapshot docSnapshot =
          await _firestore.collection('user_emails').doc(userEmail).get();

      if (docSnapshot.exists) {
        setState(() {
          _isUnique = false;
        });
      } else {
        setState(() {
          _isUnique = true;
        });
      }
    } catch (e) {
      print('에러 발생');
    }
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          decoration: InputDecoration(
                            hintText: '이메일',
                          ),
                          onSaved: (value) {
                            userEmail = value!;
                          },
                          onChanged: (value) {
                            userEmail = value;
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
                          onPress: () {
                            _tryValidation();
                          },
                          width: 169.w,
                          height: 75.h),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '패스워드',
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '패스워드',
                    ),
                  ),
                  Text(
                    '영문,숫자,특수문자를 모두 포함해 10자 이상으로 구성해주세요.',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Color.fromRGBO(183, 183, 183, 1)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '패스워드 확인',
                    ),
                  ),
                  Text(
                    '비밀번호가 일치하지 않습니다.',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Color.fromRGBO(183, 183, 183, 1)),
                  ),
                  SizedBox(
                    height: 290,
                  ),
                  SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
