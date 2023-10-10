import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/model/meat_model.dart';

class InsertionTraceNumNotEditableViewModel with ChangeNotifier {
  final MeatModel meatModel;
  InsertionTraceNumNotEditableViewModel(this.meatModel) {
    initialize();
  }

  final List<String?> tableData = [];

  int isAllInserted = 0;

  String? traceNum;
  String? birthYmd;
  String? species;
  String? sexType;
  String? farmerNm;
  String? farmAddr;
  String? butcheryYmd;
  String? gradeNum;

  // 초기 실행 함수
  void initialize() {
    if (meatModel.traceNum != null) {
      traceNum = meatModel.traceNum;
      birthYmd = meatModel.birthYmd;
      species = meatModel.speciesValue;
      sexType = meatModel.sexType;
      farmerNm = meatModel.farmerNm;
      farmAddr = meatModel.farmAddr;
      butcheryYmd = meatModel.butcheryYmd;
      gradeNum = meatModel.gradeNum;
      tableData.addAll([
        traceNum,
        birthYmd,
        species,
        sexType,
        farmerNm,
        farmAddr,
        butcheryYmd,
        gradeNum
      ]);
      isAllInserted = 1;
    }
  }

  void clickedNextButton(BuildContext context) {
    context.go('/home/data-manage-normal/edit/trace/info');
  }
}
