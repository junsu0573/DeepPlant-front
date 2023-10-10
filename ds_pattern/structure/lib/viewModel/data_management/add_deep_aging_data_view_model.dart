import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:structure/config/userfuls.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';
import 'package:intl/intl.dart';

class AddDeepAgingDataViewModel with ChangeNotifier {
  MeatModel meatModel = MeatModel();

  AddDeepAgingDataViewModel({required this.meatModel});

  final TextEditingController textEditingController = TextEditingController();
  DateTime selected = DateTime.now();
  DateTime focused = DateTime.now();

  // 대상 값들이 입력되었는지 확인
  bool isInsertedMinute = false;
  bool isSelectedDate = false;

  // 대상 값들이 들어오게 될 변수
  String selectedMonth = DateTime.now().month.toString();
  String selectedDay = DateTime.now().day.toString();
  String selectedYear = DateTime.now().year.toString();
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? selectedMinute;

  // 현재 위치를 결정 지음 -> picker를 바꾼 후 수정 예정
  int fieldValue = 0;

  void changeState(String state) {
    if (state == '선택' && isSelectedDate == false) {
      isSelectedDate = true;
    } else if (state == '선택' && isSelectedDate == true) {
      isSelectedDate = false;
    } else if (int.parse(state) != 0) {
      selectedMinute = state;
      isInsertedMinute = true;
    } else {
      isInsertedMinute = false;
    }

    notifyListeners();
  }

  void onDaySelected(DateTime selectedDays, DateTime focusedDay) {
    selected = selectedDays;
    focused = focusedDay;
    selectedMonth = selected.month.toString();
    selectedYear = selected.year.toString();
    selectedDay = selected.day.toString();

    setDate();
    notifyListeners();
  }

  void setDate() {
    // 이거 위에 선언한 값이 정상적이면, 줄일 수 있을 것이다.
    if (int.parse(selectedMonth) < 10) {
      selectedMonth = '0$selectedMonth';
    }
    if (int.parse(selectedDay) < 10) {
      selectedDay = '0$selectedDay';
    }
    selectedDate = '$selectedYear-$selectedMonth-$selectedDay';
  }

  late BuildContext _context;
  Future<void> saveData(BuildContext context) async {
    setDate();

    // String data = '$selectedDate/$selectedMinute';
    int seqno = meatModel.deepAgingData!.length + 1;
    String jsonData = jsonEncode({
      "id": meatModel.id,
      "userId": meatModel.createUser,
      "createdAt": Usefuls.getCurrentDate(),
      "period": 0,
      "seqno": seqno,
      "deepAging": {
        "date": '$selectedYear$selectedMonth$selectedDay',
        "minute": int.parse(selectedMinute!),
      }
    });
    print(jsonData);
    try {
      dynamic response =
          await RemoteDataSource.sendMeatData('deep_aging_data', jsonData);
      if (response == null) {
        throw Error();
      } else {
        meatModel.deepAgingData!.add({
          "deepAgingNum": '$seqno회',
          "date": '$selectedYear$selectedMonth$selectedDay',
          "minute": int.parse(selectedMinute!),
          "complete": false
        });
        _context = context;
        _movePage();
      }
    } catch (e) {
      print("에러발생: $e");
    }
  }

  void _movePage() {
    Navigator.pop(_context);
  }
}
