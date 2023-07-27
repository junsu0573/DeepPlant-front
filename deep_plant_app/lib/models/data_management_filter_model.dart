import 'package:flutter/widgets.dart';

class FilterModel {
  List<bool>? confirmSelections1;
  List<bool>? confirmSelections2;
  List<bool>? confirmSelections3;

  String? confirmOption1;
  String? confirmOption2;
  String? confirmOption3;

  List<Widget>? confirmOptions1;

  DateTime? rangeStart;
  DateTime? rangeEnd;

  String? temp1;
  String? temp2;

  bool? flag;

  void resetCon() {
    confirmSelections1 = [true, false, false, false];
    confirmSelections2 = [true, false, false, false];
    confirmSelections3 = [false, false, true];
    confirmOption1 = '3일';
    confirmOption2 = '나의 데이터';
    confirmOption3 = '전체';
    rangeStart = null;
    rangeEnd = null;
    flag = false;
    temp1 = '';
    temp2 = '';
    confirmOptions1 = [
      Text('3일'),
      Text('1개월'),
      Text('3개월'),
      Text('직접설정'),
    ];
  }

  FilterModel({
    this.confirmSelections1,
    this.confirmSelections2,
    this.confirmSelections3,
    this.confirmOption1,
    this.confirmOption2,
    this.confirmOption3,
    this.confirmOptions1,
    this.rangeStart,
    this.rangeEnd,
    this.temp1,
    this.temp2,
    this.flag,
  });
}
