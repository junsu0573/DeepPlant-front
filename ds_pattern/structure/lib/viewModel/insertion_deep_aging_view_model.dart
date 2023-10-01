import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';

class InsertionDeepAgingViewModel with ChangeNotifier {
  MeatModel meatModel = MeatModel();

  InsertionDeepAgingViewModel({required this.meatModel});

  final TextEditingController textEditingController = TextEditingController();
  DateTime selected = DateTime.now();
  DateTime focused = DateTime.now();

  // 대상 값들이 입력되었는지 확인
  bool isInsertedMinute = false;
  bool isAllnotSelected = true;

  // 년, 월, 일 필드의 활성화 상태를 제어함.
  bool isSelectedmonth = false;
  bool isSelectedday = false;
  bool isSelectedyear = false;

  // 대상 값들이 들어오게 될 변수
  String selectedMonth = DateTime.now().month.toString();
  String selectedDay = DateTime.now().day.toString();
  String selectedYear = DateTime.now().year.toString();
  String? selectedMinute;

  // 월 데이터 필드
  List<String> monthData = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
  // 2023 ~ 2003 까지의 연도 필드
  List<int> yearData = List<int>.generate(2023 - 2003 + 1, (int index) => 2023 - index);
  // 연도의 현재 위치를 결정 지음
  int yearFieldValue = 0;

  void reset() {
    isSelectedmonth = false;
    isSelectedday = false;
    isSelectedyear = false;
    isAllnotSelected = true;
    notifyListeners();
  }

  void changeState(String state) {
    if (state == "Day") {
      isSelectedday = true;
      isSelectedmonth = false;
      isSelectedyear = false;
    } else if (state == "Month") {
      isSelectedday = false;
      isSelectedmonth = true;
      isSelectedyear = false;
    } else if (state == "Year") {
      isSelectedday = false;
      isSelectedmonth = false;
      isSelectedyear = true;
    } else {
      selectedMinute = state;
      isInsertedMinute = true;
    }
    notifyListeners();
  }

  void saveData() {
    if (int.parse(selectedMonth) < 10) {
      selectedMonth = '0$selectedMonth';
    }
    if (int.parse(selectedDay) < 10) {
      selectedDay = '0$selectedDay';
    }
    String data = '$selectedYear$selectedMonth$selectedDay/$selectedMinute';
    if (meatModel.deepAging != null) {
      meatModel.deepAging!.add(data);
    } else {
      meatModel.deepAging = [data];
    }
  }
  // 받는 함수에서 화면 갱신 필요!!
}
