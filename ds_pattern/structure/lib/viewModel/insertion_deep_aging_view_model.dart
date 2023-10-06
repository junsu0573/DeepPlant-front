import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';
import 'package:intl/intl.dart';

class InsertionDeepAgingViewModel with ChangeNotifier {
  MeatModel meatModel = MeatModel();

  InsertionDeepAgingViewModel({required this.meatModel});

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

  void saveData() {
    setDate();
    String data = '$selectedDate/$selectedMinute';
    if (meatModel.deepAging != null) {
      meatModel.deepAging!.add(data);
    } else {
      meatModel.deepAging = [data];
    }
  }
}
