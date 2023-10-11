import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/components/custom_dialog.dart';
import 'package:structure/components/custom_pop_up.dart';
import 'package:structure/dataSource/local_data_source.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

class MeatRegistrationViewModel with ChangeNotifier {
  MeatModel meatModel;
  UserModel userModel;

  MeatRegistrationViewModel({
    required this.meatModel,
    required this.userModel,
  });
  bool isLoading = false;

  void initialize(BuildContext context) {
    // 육류 인스턴스 초기화
    meatModel.reset();

    // 육류 생성은 seqno: 0
    meatModel.seqno = 0;

    // 임시저장 데이터 fetch
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkTempData(context);
    });
  }

  late BuildContext _context;
  Future<void> checkTempData(BuildContext context) async {
    try {
      dynamic response = await LocalDataSource.getLocalData(meatModel.userId!);
      if (response == null) {
        Error();
      } else {
        _context = context;
        await _showTempDataDialog(response);
        notifyListeners();
      }
    } catch (e) {
      print('에러발생: $e');
    }
  }

  Future<void> _showTempDataDialog(dynamic response) async {
    showDataRegisterDialog(_context, () async {
      // 처음부터
      await LocalDataSource.deleteLocalData(meatModel.userId!);
      popDialog();
    }, () async {
      // 이어서
      isLoading = true;
      notifyListeners();
      meatModel.fromJsonTemp(response);
      isLoading = false;
      notifyListeners();
      popDialog();
    });
  }

  void popDialog() {
    _context.pop();
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

  Future<void> clickedTempSaveButton(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      dynamic response = await LocalDataSource.saveDataToLocal(
          meatModel.toJsonTemp(), meatModel.userId!);
      if (response == null) Error();
      isLoading = false;
      notifyListeners();
      _context = context;
      _showTempSavePopup();
    } catch (e) {
      print('에러발생: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  void _showTempSavePopup() {
    showTemporarySavePopup(_context);
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
