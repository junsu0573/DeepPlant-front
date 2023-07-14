import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MeatData {
  // 관리 번호 생성 시 저장
  String? id;
  String? userId;
  String? createdAt;

  // 육류 오픈 API 데이터
  String? traceNum;
  String? farmAddr;
  String? farmerNm;
  String? butcheryYmd;
  String? birthYmd;
  String? sexType;
  String? lsType;
  String? gradeNum;

  // 육류 추가 정보
  String? speciesValue;
  String? primalValue;
  String? secondaryValue;

  // 육류 이미지 경로
  String? imagePath;

  Map<String, dynamic>? freshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  int? period;
  List<String>? deepAging;
  Map<String, dynamic>? heatedmeat;
  Map<String, dynamic>? tongueData;
  Map<String, dynamic>? labData;

  MeatData({
    // 관리 번호 생성 시 저장
    this.id,
    this.userId,
    this.createdAt,
    this.traceNum,
    this.farmAddr,
    this.farmerNm,
    this.butcheryYmd,
    this.birthYmd,
    this.sexType,
    this.lsType,
    this.gradeNum,
    this.speciesValue,
    this.primalValue,
    this.secondaryValue,
    this.imagePath,
    this.freshmeat,

    // 연구 데이터 추가 입력 완료 시 저장
    this.period,
    this.deepAging,
    this.heatedmeat,
    this.tongueData,
    this.labData,
  });

  // 변수 초기화
  void resetData() {
    id = null;

    createdAt = null;
    traceNum = null;
    farmAddr = null;
    farmerNm = null;
    butcheryYmd = null;
    birthYmd = null;
    sexType = null;
    lsType = null;
    gradeNum = null;
    speciesValue = null;
    primalValue = null;
    secondaryValue = null;
    imagePath = null;
    freshmeat = null;

    period = null;
    deepAging = null;
    heatedmeat = null;
    tongueData = null;
    labData = null;
  }

  // 임시 데이터를 로컬 임시 파일로 저장
  Future<void> saveDataToLocal(Map<String, dynamic> data, String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$path');

    await file.writeAsString(jsonEncode(data));
  }

  // 객체 데이터를 임시 저장 데이터로 초기화
  Future<void> initMeatData(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$path');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);

      // 육류 오픈 API 데이터
      traceNum = data['traceNum'];
      farmAddr = data['farmAddr'];
      farmerNm = data['farmerNm'];
      butcheryYmd = data['butcheryYmd'];
      birthYmd = data['birthYmd'];
      sexType = data['sexType'];
      lsType = data['lsType'];
      gradeNum = data['gradeNum'];

      // 육류 추가 정보
      speciesValue = data['speciesValue'];
      primalValue = data['primalValue'];
      secondaryValue = data['secondaryValue'];

      // 육류 이미지 경로
      imagePath = data['imagePath'];

      // 신선육 관능평가
      freshmeat = data['freshmeat'];

      // 육류 추가 데이터
      deepAging = data['deepAging'];
      heatedmeat = data['heatedmeat'];
      tongueData = data['tongueData'];
      labData = data['labData'];
    }
  }

  // 임시저장 데이터 저장
  Future<void> saveTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempData = {
      // 육류 오픈 API 데이터
      'traceNum': traceNum,
      'farmAddr': farmAddr,
      'farmerNm': farmerNm,
      'butcheryYmd': butcheryYmd,
      'birthYmd': birthYmd,
      'sexType': sexType,
      'lsType': lsType,
      'gradeNum': gradeNum,

      // 육류 추가 정보
      'speciesValue': speciesValue,
      'primalValue': primalValue,
      'secondaryValue': secondaryValue,

      // 육류 이미지 경로
      'imagePath': imagePath,

      // 신선육 관능평가
      'freshmeat': freshmeat,

      // 육류 추가 데이터
      'deepAging': deepAging,
      'heatedmeat': heatedmeat,
      'tongueData': tongueData,
      'labData': labData,
    };
    await saveDataToLocal(tempData, userId!);
  }

  // 임시저장 데이터 리셋
  Future<void> resetTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempData = {
      // 육류 오픈 API 데이터
      'traceNum': null,
      'farmAddr': null,
      'farmerNm': null,
      'butcheryYmd': null,
      'birthYmd': null,
      'sexType': null,
      'lsType': null,
      'gradeNum': null,

      // 육류 추가 정보
      'speciesValue': null,
      'primalValue': null,
      'secondaryValue': null,

      // 육류 이미지 경로
      'imagePath': null,

      // 신선육 관능평가
      'freshmeat': null,

      // 육류 추가 데이터
      'deepAging': null,
      'heatedmeat': null,
      'tongueData': null,
      'labData': null,
    };

    await saveDataToLocal(tempData, userId!);
  }

  // 신규 육류 데이터를 json 형식으로 변환
  String convertNewMeatToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'traceNum': traceNum,
      'farmAddr': farmAddr,
      'farmerNm': farmerNm,
      'butcheryYmd': butcheryYmd,
      'birthYmd': birthYmd,
      'sexType': sexType,
      'freshmeat': freshmeat,
      'speciesValue': speciesValue,
      'primalValue': primalValue,
      'secondaryValue': secondaryValue,
    };

    return jsonEncode(jsonData);
  }

  // 가열육 데이터를 json 형식으로 변환
  String convertHeatedMeatToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'heatedmeat': heatedmeat,
    };

    return jsonEncode(jsonData);
  }

  // 실험 데이터를 json 형식으로 변환
  String convertPorbexptToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'probexpt': _getProbexpt(),
    };

    return jsonEncode(jsonData);
  }

  Map<String, dynamic> _getProbexpt() {
    Map<String, dynamic> probexpt = {};

    if (tongueData != null && labData != null) {
      probexpt['createdAt'] = createdAt;
      probexpt['userId'] = userId;
      probexpt['period'] = period;
      probexpt['L'] = labData!['L'];
      probexpt['a'] = labData!['a'];
      probexpt['b'] = labData!['b'];
      probexpt['DL'] = labData!['DL'];
      probexpt['CL'] = labData!['CL'];
      probexpt['RW'] = labData!['RW'];
      probexpt['ph'] = labData!['ph'];
      probexpt['WBSF'] = labData!['WBSF'];
      probexpt['cardepsin_activity'] = labData!['cardepsin_activity'];
      probexpt['MFI'] = labData!['MFI'];
      probexpt['Collagen'] = labData!['Collagen'];
      probexpt['sourness'] = tongueData!['sourness'];
      probexpt['bitterness'] = tongueData!['bitterness'];
      probexpt['umami'] = tongueData!['umami'];
      probexpt['richness'] = tongueData!['richness'];
    }

    return probexpt;
  }
}
