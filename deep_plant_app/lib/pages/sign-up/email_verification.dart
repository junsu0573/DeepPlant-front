import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 회원가입 및 인증
  Future<void> signUpWithVerify() async {
    try {
      // 새로운 유저 생성
      UserCredential credential =
          await _authentication.createUserWithEmailAndPassword(
              email: widget.userData.userId!,
              password: widget.userData.password!);
      // 이메일 인증 보내기
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
      } else {
        throw Error();
      }
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
    // user의 정보를 저장하는 API 호출
    /////////////////////////////
    // 코드 수정 필요함
    /////////////////////////////
    CollectionReference users = _firestore.collection('users_1');

    // 데이터 생성
    DateTime now = DateTime.now();
    String saveTime = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    List<String> meatList = [];

    Map<String, dynamic> data = {
      'meatList': meatList,
      'name': widget.user.name,
      'lastLogin': saveTime,
      'company': widget.user.company,
      'companyAdress': widget.user.companyAdress,
      'position': widget.user.position,
    };

    // 데이터 저장 (users_1/user-email 문서)
    DocumentReference document = users.doc(widget.user.email);
    await document.set(data);

    // email 모음 데이터에 저장
    CollectionReference email = _firestore.collection('user_emails');

    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'historyNumber': null,
      'species': null,
      'lDivision': null,
      'sDivision': null,
      'gradeNm': null,
      'farmAddr': null,
      'butcheryPlaceNm': null,
      'butcheryYmd': null,
      'freshData': null,
      'imageFile': null,
    };

    Map<String, dynamic> defaultData = {
      'level': widget.user.level,
      'isAlarmed': widget.user.isAlarmed,
      'temp_basic_data': tempBasicData,
    };

    // 데이터 저장
    DocumentReference doc = email.doc(widget.user.email);
    await doc.set(defaultData);

    // 0-0-0-0-0 에 user email 저장
    DocumentReference documentRef =
        _firestore.collection('meat').doc('0-0-0-0-0');
    DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        Map<String, dynamic>? fixField =
            data['fix_data'] as Map<String, dynamic>?;

        if (fixField != null) {
          List<dynamic>? userArray = fixField['users_1'] as List<dynamic>?;

          if (userArray != null) {
            userArray.add(widget.user.email);
            await documentRef.update({'fix_data.users_1': userArray});
          }
        }
      }
    }
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
