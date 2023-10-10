import 'package:flutter/material.dart';
import 'package:structure/model/meat_model.dart';

class FreshMeatEvalNotEditableViewModel with ChangeNotifier {
  MeatModel meatModel;
  bool isDeepAged;
  FreshMeatEvalNotEditableViewModel(this.meatModel, this.isDeepAged) {
    meatImage = meatModel.imagePath!;
    marbling = meatModel.freshmeat!["marbling"];
    color = meatModel.freshmeat!["color"];
    texture = meatModel.freshmeat!['texture'];
    surface = meatModel.freshmeat!['surfaceMoisture'];
    overall = meatModel.freshmeat!['overall'];
  }

  String meatImage = '';

  double marbling = 0;
  double color = 0;
  double texture = 0;
  double surface = 0;
  double overall = 0;
}
