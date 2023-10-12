import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/model/meat_model.dart';

class InsertionMeatInfoNotEditableViewModel with ChangeNotifier {
  MeatModel meatModel;
  InsertionMeatInfoNotEditableViewModel(this.meatModel) {
    speciesValue = meatModel.speciesValue ?? '-';
    primalValue = meatModel.primalValue ?? '-';
    secondaryValue = meatModel.secondaryValue ?? '-';
  }

  String speciesValue = '';
  String primalValue = '';
  String secondaryValue = '';

  void clickedCloseButton(BuildContext context) {
    context.go('/home/data-manage-normal/edit');
  }
}
