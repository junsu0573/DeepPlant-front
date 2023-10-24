import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/components/custom_pop_up.dart';
import 'package:structure/model/user_model.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel;
  HomeViewModel({required this.userModel});

  void clickedMyPage(BuildContext context) {
    context.go('/home/my-page');
  }

  void clickedMeatRegist(BuildContext context) {
    context.go('/home/registration');
  }

  void clickedDataManage(BuildContext context) {
    if (userModel.type == 'Normal') {
      context.go('/home/data-manage-normal');
    } else if (userModel.type == 'Researcher') {
      context.go('/home/data-manage-researcher');
    } else {
      showUserTypeErrorPopup(context);
    }
  }
}
