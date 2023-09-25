import 'package:flutter/material.dart';
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

  // initState Function
  void initialize(BuildContext context) {
    // 육류 인스턴스 초기화
    meatModel = MeatModel.reset();

    // 육류 생성은 seqno: 0
    meatModel.seqno = 0;

    // 육류 정보 생성자 id 저장
    meatModel.userId = userModel.userId;

    //팝업 띄우기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTemporarySavePopup(context);
    });
  }
}
