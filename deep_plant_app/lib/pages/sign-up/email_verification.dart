import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerification extends StatefulWidget {
  final UserModel user;
  const EmailVerification({
    super.key,
    required this.user,
  });

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  // 회원가입 및 인증
  Future<void> signUpWithVerify() async {
    try {
      // 새로운 유저 생성
      UserCredential credential =
          await _authentication.createUserWithEmailAndPassword(
              email: widget.user.email!, password: widget.user.password!);
      // 이메일 인증 보내기
      await credential.user!.sendEmailVerification();
      // 사용자의 정보를 firestore에 저장
      saveUserData();
      // 페이지 이동
      if (!mounted) return;
      context.go('/succeed-sign-up');
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
  }

  // user의 정보를 저장하는 함수
  void saveUserData() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(widget.user.level!);

    // 데이터 생성
    Map<String, dynamic> data = {
      'name': widget.user.name,
      'email': widget.user.email,
      'isAlarmed': widget.user.isAlarmed,
    };

    // 데이터 저장
    DocumentReference document = users.doc(widget.user.email);
    await document.set(data);

    // email 모음 데이터에 저장
    CollectionReference email =
        FirebaseFirestore.instance.collection('user_emails');

    // 데이터 생성
    Map<String, dynamic> defaultData = {
      'date': null,
      'freshDate': null,
      'historyNumber': null,
      'imageFile': null,
      'lDivision': null,
      'sDivision': null,
      'species': null,
      'level': widget.user.level,
    };

    // 데이터 저장
    DocumentReference doc = email.doc(widget.user.email);
    await doc.set(defaultData);
  }

  @override
  void initState() {
    super.initState();
    signUpWithVerify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('계정 생성중'),
      ),
    );
  }
}
