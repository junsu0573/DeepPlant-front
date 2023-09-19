import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';

class SignInViewModel with ChangeNotifier {
  UserModel userModel;

  SignInViewModel({required this.userModel});

  String userId = '';
  String userPw = '';
  bool isLoading = false;
  bool isAutoLogin = false;

  final formKey = GlobalKey<FormState>();

  // firbase authentic
  final _authentication = FirebaseAuth.instance;

  // 로그인 버튼 클릭 시
  Future<void> clickedSignInButton(BuildContext context) async {
    _tryValidation();
    await _signIn(context);
  }

  // 로그인 진행
  Future<void> _signIn(BuildContext context) async {
    // 로딩 상태를 활성화
    isLoading = true;
    notifyListeners();

    try {
      // 로그인 시도
      await _authentication.signInWithEmailAndPassword(
        email: userId,
        password: userPw,
      );

      // 이메일 validation
      final bool isValidEmail = await validateEmail();
      if (!isValidEmail) {
        // 이메일 invalid
        _authentication.signOut();
        throw InvalidEmailException('이메일 인증을 완료하세요.');
      } else {
        // 이메일 valid
        // 유저 정보 저장
        if (await saveUserInfo()) {
          // 로딩 상태를 비활성화
          isLoading = false;
          notifyListeners();

          // 페이지 이동
        } else {
          throw Error();
        }
      }
    } catch (e) {
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
      // 로딩 상태를 비활성화
      isLoading = false;
      notifyListeners();

      // 에러 스낵바
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Pallete.alertColor,
        ),
      );

      return;
    }
  }

  // 아이디 유효성 검사
  String? idValidate(String? email) {
    if (email!.isEmpty || !email.contains('@') || !email.contains('.')) {
      return '아이디를 확인하세요.';
    }
    return null;
  }

  // 비밀번호 유효성 검사
  String? pwValidate(String? password) {
    if (password!.isEmpty || password.length < 10 || password.length > 15) {
      return '비밀번호를 확인하세요.';
    }
    return null;
  }

  // 유효성 검사 함수
  void _tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
    }
  }

  // 유저의 이메일 valid 검사
  Future<bool> validateEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.reload();
      if (user.emailVerified) {
        return true;
      }
    } catch (e) {
      print('인증 실패');
      return false;
    }
    return false;
  }

  // 유저 정보 저장
  Future<bool> saveUserInfo() async {
    // 로그인 API 호출
    try {
      // 유저 정보 가져오기 시도
      dynamic userInfo = await RemoteDataSource.signIn(userId)
          .timeout(const Duration(seconds: 10));
      if (userInfo == null) {
        // 가져오기 실패
        return false;
      } else {
        // 가져오기 성공
        // 데이터 fetch
        UserModel.fromJson(userInfo);
        return true;
      }
    } catch (e) {
      return false;
    }
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
