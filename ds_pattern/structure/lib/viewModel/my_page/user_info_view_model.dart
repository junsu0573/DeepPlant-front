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

  UserInfoViewModel(UserModel userModel) {
    print('here');
    userName = userModel.name ?? 'None';
    userId = userModel.userId ?? 'None';
    userType = userModel.type ?? 'None';
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
    _context = context;
    await FirebaseAuth.instance.signOut();
    movePage();
  }

  void movePage() {
    _context!.go('/sign-in');
  }
}
