import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';

class FreshMeatEvalViewModel with ChangeNotifier {
  MeatModel meatModel;
  FreshMeatEvalViewModel({required this.meatModel});

  double marbling = 0;
  double color = 0;
  double texture = 0;
  double surface = 0;
  double overall = 0;

  bool completed = false;

  void onChangedMarbling(double value) {
    marbling = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedColor(double value) {
    color = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedTexture(double value) {
    texture = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedSurface(double value) {
    surface = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedOverall(double value) {
    overall = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void _checkCompleted() {
    if (marbling > 0 &&
        color > 0 &&
        texture > 0 &&
        surface > 0 &&
        overall > 0) {
      completed = true;
    } else {
      completed = false;
    }
  }
}
