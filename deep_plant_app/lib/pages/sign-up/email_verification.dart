import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerification extends StatefulWidget {
  final UserData userData;
  const EmailVerification({
    super.key,
    required this.userData,
  });

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  // firebase authentication
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  // 회원가입 및 인증
  Future<void> signUpWithVerify(UserData userData) async {
    try {
      // 새로운 유저 생성
      UserCredential credential =
          await _authentication.createUserWithEmailAndPassword(
              email: userData.userId!, password: userData.password!);

      // 이메일 인증 메일 전송
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
      } else {
        throw Error();
      }

      // 사용자의 회원가입 정보를 서버로 전송
      await ApiServices.signUp(userData);

      // 페이지 이동
      if (!mounted) return;
      context.go('/succeed-sign-up');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
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

  @override
  void initState() async {
    super.initState();
    await signUpWithVerify(widget.userData);
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
