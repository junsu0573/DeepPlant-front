import 'package:flutter/widgets.dart';

class FilterModel {
  List<bool>? viewSelections1;
  List<bool>? viewSelections2;
  List<bool>? viewSelections3;

  List<bool>? confirmSelections1;
  List<bool>? confirmSelections2;
  List<bool>? confirmSelections3;

  String? viewOption1;
  String? viewOption2;
  String? viewOption3;

  String? confirmOption1;
  String? confirmOption2;
  String? confirmOption3;

  List<Widget>? viewOptions1;
  List<Widget>? confirmOptions1;

  void resetView() {
    viewSelections1 = [false, true, false, false];
    viewSelections2 = [true, false, false, false];
    viewSelections3 = [true, false];
    viewOption1 = '1개월';
    viewOption2 = '나의 데이터';
    viewOption3 = '소고기';
    viewOptions1 = [
      Text('3일'),
      Text('1개월'),
      Text('3개월'),
      Text('직접설정'),
    ];
  }

  void resetCon() {
    confirmSelections1 = [false, true, false, false];
    confirmSelections2 = [true, false, false, false];
    confirmSelections3 = [true, false];
    confirmOption1 = '1개월';
    confirmOption2 = '나의 데이터';
    confirmOption3 = '소고기';
    confirmOptions1 = [
      Text('3일'),
      Text('1개월'),
      Text('3개월'),
      Text('직접설정'),
    ];
  }

  FilterModel({
    this.viewSelections1,
    this.viewSelections2,
    this.viewSelections3,
    this.confirmSelections1,
    this.confirmSelections2,
    this.confirmSelections3,
    this.viewOption1,
    this.viewOption2,
    this.viewOption3,
    this.confirmOption1,
    this.confirmOption2,
    this.confirmOption3,
    this.viewOptions1,
    this.confirmOptions1,
  });
}
