import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    // 유저의 이메일 valid 검사
    void getUserValid() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        context.go('/succeed-sign-up');
      } else {
        print('인증 실패');
      }
      print(user!.emailVerified);
    }

    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                '이메일 인증을 완료해주세요',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: 350,
            height: 50,
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                getUserValid();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
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
        ],
      ),
    );
  }
}
