import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/model/user_model.dart';

class CertificationBottomViewModel with ChangeNotifier {
  UserModel userModel;

  CertificationBottomViewModel({required this.userModel});

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  bool isRequiredChecked = false;

  void _checkCheckBoxValues() {
    if (isChecked1 == true && isChecked2 == true && isChecked3 == true) {
      isChecked4 = true;
    } else {
      isChecked4 = false;
    }
    if (isChecked1 == true && isChecked2 == true) {
      isRequiredChecked = true;
    } else {
      isRequiredChecked = false;
    }
    notifyListeners();
  }

  // 첫 번째 체크박스 클릭 시
  void clicked1stCheckBox(bool? value) {
    isChecked1 = value!;
    _checkCheckBoxValues();
  }

  // 두 번째 체크박스 클릭 시
  void clicked2ndCheckBox(bool? value) {
    isChecked2 = value!;
    _checkCheckBoxValues();
  }

  // 세 번째 체크박스 클릭 시
  void clicked3rdCheckBox(bool? value) {
    isChecked3 = value!;
    _checkCheckBoxValues();
  }

  // 모두 동의 클릭 시
  void clicked4thCheckBox(bool? value) {
    isChecked1 = value!;
    isChecked2 = value;
    isChecked3 = value;
    isChecked4 = value;
    _checkCheckBoxValues();
  }

  // 다음 버튼 클릭 시
  void clickedNextBotton(BuildContext context) {
    userModel.alarm = isChecked3;
    context.go('/sign-in/sign-up/user-detail');
  }
}
