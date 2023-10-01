import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kpostal/kpostal.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';

class InsertionUserDetailViewModel with ChangeNotifier {
  UserModel userModel;
  InsertionUserDetailViewModel({required this.userModel});

  final TextEditingController mainAddressController = TextEditingController();

  String subHomeAdress = '';

  String company = '';

  String department = '';

  String jobTitle = '';

  Future clickedSearchButton(context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          useLocalServer: false,
          callback: (Kpostal result) {
            mainAddressController.text = result.jibunAddress;
            notifyListeners();
          },
        ),
      ),
    );
  }

  // 다음 버튼 클릭시
  Future<void> clickedNextButton(BuildContext context) async {
    _saveUserData();
    await _sendData(context);
  }

  void _saveUserData() {
    if (mainAddressController.text.isNotEmpty) {
      userModel.homeAdress = '${mainAddressController.text}/$subHomeAdress';
    }

    userModel.company = company;
    if (department.isNotEmpty || jobTitle.isNotEmpty) {
      userModel.jobTitle = '$department/$jobTitle';
    }
  }

  // 데이터 서버로 전송
  Future<void> _sendData(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      // 사용자의 회원가입 정보를 서버로 전송
      await RemoteDataSource.signUp(_convertUserInfoToJson());

      // 새로운 유저 생성
      UserCredential credential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.userId!, password: userModel.password!);

      // 이메일 인증 메일 전송
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
      } else {
        throw Error();
      }

      context.go('/sign-in/complete-sign-up');
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

  String _convertUserInfoToJson() {
    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

    Map<String, dynamic> data = {
      "userId": userModel.userId,
      "createdAt": createdAt,
      "updatedAt": createdAt,
      "loginAt": null,
      "password": userModel.password,
      "name": userModel.name,
      "company": userModel.company,
      "jobTitle": userModel.jobTitle,
      "homeAddr": userModel.homeAdress,
      "alarm": userModel.alarm,
      "type": "Normal",
    };

    return jsonEncode(data);
  }
}
