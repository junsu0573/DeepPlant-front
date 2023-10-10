import 'package:flutter/material.dart';

class UIUpdateViewModel with ChangeNotifier {
  String filterdResult = '1개월∙최신순';

  List<String> dateList = ['3일', '1개월', '3개월', '직접입력'];
  List<bool> dateStatus = [true, false, false, false];
  int dateSelectedIdx = 0;

  List<String> sortList = ['최신순', '과거순'];
  List<bool> sortStatus = [true, false];
  int sortSelectedIdx = 0;

  void onTapDate(int index) {
    dateStatus[dateSelectedIdx] = false;
    dateSelectedIdx = index;
    dateStatus[dateSelectedIdx] = true;
    notifyListeners();
  }

  void onTapSort(int index) {
    sortStatus[sortSelectedIdx] = false;
    sortSelectedIdx = index;
    sortStatus[sortSelectedIdx] = true;
    notifyListeners();
  }
}
