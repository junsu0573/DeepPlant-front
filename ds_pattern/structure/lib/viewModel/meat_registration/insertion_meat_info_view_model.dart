import 'package:flutter/material.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class InsertionMeatInfoViewModel with ChangeNotifier {
  MeatModel meatModel;
  InsertionMeatInfoViewModel({required this.meatModel});

  String speciesValue = '';
  String primalValue = '';
  String secondaryValue = '';

  bool isSelectedSpecies = false;
  bool isSelectedPrimal = false;
  bool isSelectedSecondary = false;

  List<String> largeDiv = [];
  List<String> litteDiv = [];
  Map<String, dynamic>? dataTable;

  void initialize() async {
    if (meatModel.speciesValue != null) {
      fetchMeatData();
    }

    Map<String, dynamic> data = await RemoteDataSource.getMeatSpecies();
    setSpecies();
    dataTable = data[speciesValue];

    List<String> lDiv = [];
    for (String key in dataTable!.keys) {
      lDiv.add(key);
    }

    largeDiv = lDiv;
    if (meatModel.secondaryValue != null) {
      setPrimal();
      setSecondary();
    }
    notifyListeners();
  }

  // 육류 정보 저장
  void saveMeatData() {
    meatModel.speciesValue = speciesValue;
    meatModel.primalValue = primalValue;
    meatModel.secondaryValue = secondaryValue;
  }

  // 육류 정보 fetch
  void fetchMeatData() {
    speciesValue = meatModel.speciesValue!;
    primalValue = meatModel.primalValue!;
    secondaryValue = meatModel.secondaryValue!;
  }

  // 종 분류 지정
  void setSpecies() {
    isSelectedSpecies = true;
    isSelectedPrimal = false;
    isSelectedSecondary = false;
    primalValue = '';
    secondaryValue = '';
    notifyListeners();
  }

  // 대분류 지정
  void setPrimal() {
    isSelectedPrimal = true;
    secondaryValue = '';
    isSelectedSecondary = false;
    litteDiv = List<String>.from(
        dataTable![primalValue].map((element) => element.toString()));
    notifyListeners();
  }

  // 소분류 지정
  void setSecondary() {
    isSelectedSecondary = true;
    notifyListeners();
  }

  bool isAllChecked() {
    if (isSelectedPrimal && isSelectedSecondary && isSelectedSpecies) {
      return true;
    }
    return false;
  }
}
