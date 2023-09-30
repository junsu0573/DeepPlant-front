import 'package:flutter/material.dart';
import 'package:structure/model/user_model.dart';
import 'package:intl/intl.dart';

class UserInfoViewModel with ChangeNotifier {
  String? userName;
  String? userId;
  String? userType;
  String? createdAt;

  UserInfoViewModel(UserModel userModel) {
    userName = userModel.name;
    userId = userModel.userId;
    userType = userModel.type;
    createdAt = _formatDate(userModel.createdAt);
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    DateFormat format = DateFormat("E, dd MMM yyyy HH:mm:ss 'GMT'");
    DateTime dateTime = format.parse(dateString);

    String formattedDate = DateFormat("yyyy/MM/dd").format(dateTime);
    return formattedDate;
  }
}
