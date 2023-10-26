import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class InsertionMeatInfoViewModel with ChangeNotifier {
  MeatModel meatModel;
  InsertionMeatInfoViewModel(this.meatModel) {
    initialize();
  }

  String speciesValue = '';
  String? primalValue;
  String? secondaryValue;

  bool isSelectedSpecies = false;
  bool isSelectedPrimal = false;
  bool isSelectedSecondary = false;
  bool completed = false;

  List<String> largeDiv = [];
  List<String> litteDiv = [];
  Map<String, dynamic>? dataTable;

  Future<void> initialize() async {
    if (meatModel.speciesValue != null) {
      // fetchMeatData();
      if (meatModel.speciesValue! == '한우') {
        speciesValue = '소';
      } else {
        speciesValue = meatModel.speciesValue!;
      }
      isSelectedSpecies = true;
    }
    // data fetch
    if (meatModel.secondaryValue != null) {
      primalValue = meatModel.primalValue;
      secondaryValue = meatModel.secondaryValue;
      isSelectedPrimal = true;
      isSelectedSecondary = true;
      completed = true;
    }

    Map<String, dynamic> data = await RemoteDataSource.getMeatSpecies();

    dataTable = data[speciesValue];

    List<String> lDiv = [];

    if (dataTable != null) {
      for (String key in dataTable!.keys) {
        lDiv.add(key);
      }
    }

    largeDiv = lDiv;
    if (isSelectedSecondary) {
      litteDiv = List<String>.from(dataTable![primalValue].map((element) => element.toString()));
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
    primalValue = null;
    secondaryValue = null;
    notifyListeners();
  }

  // 대분류 지정
  void setPrimal() {
    isSelectedPrimal = true;
    secondaryValue = null;
    isSelectedSecondary = false;
    litteDiv = List<String>.from(dataTable![primalValue].map((element) => element.toString()));
    completed = false;
    notifyListeners();
  }

  // 소분류 지정
  void setSecondary() {
    isSelectedSecondary = true;
    completed = true;
    notifyListeners();
  }

  late BuildContext _context;
  Future<void> clickedNextButton(BuildContext context) async {
    saveMeatData();
    meatModel.checkCompleted();
    if (meatModel.id != null) {
      final response = await RemoteDataSource.sendMeatData(null, meatModel.toJsonBasic());

      if (response == null) {
        // 에러 페이지
      } else {
        _context = context;
        _movePage();
      }
    } else {
      context.go('/home/registration');
    }
  }

  void _movePage() {
    _context.go('/home/data-manage-normal/edit');
  }
}
