import 'dart:io';

import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

class InsertionMeatImageNotEditableViewModel with ChangeNotifier {
  final MeatModel meatModel;
  final UserModel userModel;
  final int imageIdx;

  InsertionMeatImageNotEditableViewModel(
      this.meatModel, this.userModel, this.imageIdx) {
    fetchDate(meatModel.createdAt!);
    imagePath = meatModel.imagePath;
    date = '${time.year}.${time.month}.${time.day}';
    userName = meatModel.createUser!;
  }

  String date = '-';
  String userName = '-';

  late DateTime time;
  File? pickedImage;
  String? imagePath;
  bool isLoading = false;

  void fetchDate(String dateString) {
    DateTime? date = _parseDate(dateString);
    print(dateString);
    if (date != null) {
      time = date;
    } else {
      print('DateString format is not valid.');
    }
  }

  DateTime? _parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }
}
