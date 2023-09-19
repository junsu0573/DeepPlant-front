import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';

class SingInViewModel with ChangeNotifier {
  final UserModel usermodel;
  late GlobalKey<FormState> _formKey;
  SingInViewModel({
    required this.usermodel,
    required formKey,
  }) {
    resetData();
    _formKey = formKey;
  }

  // 인증에 필요한 변수들
  final String _userId = '';
  final String _userPw = '';
  // bool? _isAutoLogin = false;
  final _authentication = FirebaseAuth.instance;

  // model을 reset하는 함수.
  void resetData() {
    usermodel.userId = null;
    usermodel.password = null;
    usermodel.name = null;
    usermodel.homeAdress = null;
    usermodel.company = null;
    usermodel.jobTitle = null;
    usermodel.type = 'Normal';
    usermodel.createdAt = null;
    usermodel.alarm = null;
  }

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

  // 데이터 호출 및 저장
  Future<void> signIn(BuildContext context) async {
    // context를 보내야. snackbar를 표시할 수 있음.

    try {
      // 유저의 이메일이 valid 해야 로그인 진행
      await _authentication.signInWithEmailAndPassword(
        email: _userId,
        password: _userPw,
      );
      final bool isValidEmail = await getUserValid();
      if (!isValidEmail) {
        _authentication.signOut();

        throw InvalidEmailException('이메일 인증을 완료하세요.');
      }

      // 유저 정보 저장
      await saveUserInfo();
    } catch (e) {
      // 로딩 상태를 비활성화

      // 예외 처리
      String errorMessage;
      if (e is FirebaseException) {
        // 로그인 실패
        errorMessage = '아이디와 비밀번호를 확인하세요.';
      } else if (e is InvalidEmailException) {
        // 이메일 인증 미완료
        errorMessage = e.message;
      } else {
        // 기타 오류
        errorMessage = '오류가 발생했습니다.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.amber,
        ),
      );
      notifyListeners();
      return;
    }
  }

  // 유저의 이메일 valid 검사
  Future<bool> getUserValid() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.reload();
      if (user.emailVerified) {
        return true;
      }
    } catch (e) {
      print('인증 실패');
    }
    return false;
  }

  // 유저 정보 저장
  Future<void> saveUserInfo() async {
    // 로그인 API 호출
    dynamic userInfo = await RemoteDataSource.signIn(_userId);
    if (userInfo == null) {
      // 에러 메시지 호출
      return;
    }

    // 데이터 fetch
    if (userInfo != null) {
      UserModel.fromJson(userInfo);
    }

    // 로딩 상태를 비활성화
  }
}

// 이메일 인증 예외 처리
class InvalidEmailException implements Exception {
  final String message;

  InvalidEmailException(this.message);

  @override
  String toString() {
    return 'InvalidEmailException: $message';
  }
}
