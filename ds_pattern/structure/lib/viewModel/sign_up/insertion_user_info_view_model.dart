import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:structure/screen/sign_up/certification_bottom_screen.dart';
import 'package:structure/components/custom_pop_up.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';
import 'package:structure/viewModel/sign_up/certification_bottom_view_model.dart';

class InsertionUserInfoViewModel with ChangeNotifier {
  final UserModel userModel;
  InsertionUserInfoViewModel({required this.userModel});

  // form
  final formKey = GlobalKey<FormState>();

  bool isUnique = false;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userCPassword = '';

  // 버튼 활성화 확인을 위한 변수
  bool isValidId = false;
  bool isValidPw = false;
  bool isValidCPw = false;

  // validation 문구를 위한 변수
  bool isRedTextId = false;
  bool isRedTextPw = false;
  bool isRedTextCPw = false;

  // email 입력 시
  void insertedEmail(String value) {
    userEmail = value;
    isUnique = false;
    tryValidation();
    notifyListeners();
  }

  // password 입력 시
  void insertedPw(String value) {
    userPassword = value;
    tryValidation();
    notifyListeners();
  }

  // Cpassword 입력 시
  void insertedCPw(String value) {
    userCPassword = value;
    tryValidation();
    notifyListeners();
  }

  // 아이디 유효성 검사
  String? idValidate(String? value) {
    // 비어있지 않고 이메일 형식에 맞지 않을 때, 빨간 예외 메시지
    final bool isValid = EmailValidator.validate(value!);
    if (value.isEmpty) {
      isValidId = false;
      isRedTextId = false;

      return null;
    } else if (!isValid) {
      isValidId = false;
      isRedTextId = true;

      return null;
    } else {
      isValidId = true;
      isRedTextId = false;

      return null;
    }
  }

  // 비밀번호 유효성 검사
  String? pwValidate(String? value) {
    // 비어있지 않고 비밀번호 형식에 맞지 않을 때, 빨간 에러 메시지
    final bool isValid = validatePassword(value!);
    if (value.isEmpty) {
      isValidPw = false;
      isRedTextPw = false;

      return null;
    } else if (!isValid) {
      isValidPw = false;
      isRedTextPw = true;

      return null;
    }

    isValidPw = true;
    isRedTextPw = false;

    return null;
  }

  // 비밀번호 재입력 유효성 검사
  String? cPwValidate(String? value) {
    // 비어있지 않고 비밀번호와 같지 않을 때, 빨간 에러 메시지
    if (value!.isEmpty) {
      isValidCPw = false;
      isRedTextCPw = false;

      return null;
    } else if (userPassword != userCPassword) {
      isValidCPw = false;
      isRedTextCPw = true;

      return null;
    }

    isValidCPw = true;
    isRedTextCPw = false;

    return null;
  }

  // 유효성 검사 함수
  void tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
    }
  }

  // 비밀번호 유효성 검사 (정규식)
  bool validatePassword(String password) {
    // 조건: 영문 대/소문자, 숫자, 특수문자 10자~15자
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\-_=+{};:,<.>]).{10,15}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(password);
  }

  // 이메일 중복 검사
  Future<void> dupliCheck(BuildContext context) async {
    bool isDuplicated = await RemoteDataSource.dupliCheck(userEmail);
    if (isDuplicated) {
      isUnique = false;
      notifyListeners();
      // popup 창 띄우기
      showDuplicateEmailPopup(context);
    } else {
      isUnique = true;
      notifyListeners();
    }
  }

  // 모든 값이 올바르게 입력됐는지 확인
  bool isAllChecked() {
    if (isValidId &&
        isValidPw &&
        isValidCPw &&
        isUnique &&
        userName.isNotEmpty) {
      return true;
    }
    return false;
  }

  void saveUserInfo() {
    // user의 이메일, 패스워드, 이름을 객체에 저장
    userModel.userId = userEmail;
    userModel.password = userPassword;
    userModel.name = userName;
  }

  void clickedNextButton(BuildContext context) {
    showModalBottomSheet(
      // isScrollControlled = true,
      // colorScheme.background = Colors.transparent,
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CertificationBottomViewModel(userModel: userModel),
        child: const CertificationBottomScreen(),
      ),
    );
  }
}
