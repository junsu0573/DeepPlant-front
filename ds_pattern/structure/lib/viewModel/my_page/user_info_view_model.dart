import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/model/user_model.dart';
import 'package:intl/intl.dart';

class UserInfoViewModel with ChangeNotifier {
  String userName = '';
  String userId = '';
  String userType = '';
  String createdAt = '';
  UserModel userModel;
  UserInfoViewModel(this.userModel) {
    _initialize();
  }

  void _initialize() {
    userName = userModel.name ?? 'None';
    if (userModel.type != null) {
      if (userModel.type == 'Normal') {
        userType = '일반데이터 수집자';
      } else if (userModel.type == 'Researcher') {
        userType = '연구데이터 수집자';
      } else {
        userType = 'None';
      }
    } else {
      userName = 'None';
    }
    userId = userModel.userId ?? 'None';
    createdAt = _formatDate(userModel.createdAt) ?? 'None';
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    DateFormat format = DateFormat("E, dd MMM yyyy HH:mm:ss 'GMT'");
    DateTime dateTime = format.parse(dateString);

    String formattedDate = DateFormat("yyyy/MM/dd").format(dateTime);
    return formattedDate;
  }

  BuildContext? _context;

  Future<void> clickedSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    _context = context;
    movePage();
  }

  void clickedEdit(BuildContext context) {
    context.go('/home/my-page/user-detail');
  }

  void movePage() {
    _context!.go('/sign-in');
  }
}
