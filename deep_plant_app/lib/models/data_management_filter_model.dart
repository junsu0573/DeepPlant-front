import 'package:flutter/widgets.dart';

class FilterModel {
  List<bool>? confirmSelections1;
  List<bool>? confirmSelections2;
  List<bool>? confirmSelections3;

  String? confirmOption1;
  String? confirmOption2;
  String? confirmOption3;

  List<Widget>? confirmOptions1;

  void resetCon() {
    confirmSelections1 = [false, true, false, false];
    confirmSelections2 = [true, false, false, false];
    confirmSelections3 = [true, false];
    confirmOption1 = '1개월';
    confirmOption2 = '나의 데이터';
    confirmOption3 = '소';
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
  });
}
