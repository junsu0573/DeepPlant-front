import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/components/custom_pop_up.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

class MeatRegistrationViewModel with ChangeNotifier {
  MeatModel meatModel;
  UserModel userModel;

  MeatRegistrationViewModel({
    required this.meatModel,
    required this.userModel,
  });

  void initialize(BuildContext context) {
    // 육류 인스턴스 초기화
    meatModel.reset();

    // 육류 생성은 seqno: 0
    meatModel.seqno = 0;

    // 임시저장 데이터 fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTemporarySavePopup(context);
    });
  }

  void clickedBasic(BuildContext context) {
    context.go('/home/registration/trace-num');
  }

  void clickedImage(BuildContext context) {
    context.go('/home/registration/image');
  }

  void clickedFreshmeat(BuildContext context) {
    context.go('/home/registration/freshmeat');
  }

  void clickedSaveButton(BuildContext context) {
    if (userModel.type == 'Normal') {
      context.go('/home/success-registration-normal');
    } else if (userModel.type == 'Researcher') {
      context.go('/home/success-registration-researcher');
    } else {
      showUserTypeErrorPopup(context);
    }
  }
}
