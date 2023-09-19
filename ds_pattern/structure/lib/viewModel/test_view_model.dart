import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';

class TestViewModel with ChangeNotifier {
  final MeatModel meatModel;
  TestViewModel({required this.meatModel});

  void anyFunc() {
    // view control code
    notifyListeners();
  }
}
