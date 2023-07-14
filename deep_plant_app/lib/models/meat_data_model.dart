import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
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
    this.deepAging,
    this.heatedmeat,
    this.tongueData,
    this.labData,
  });

  // 변수 초기화
  void resetDataForStep1() {
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
  }

  void resetDataForStep2() {
    createdAt = null;
    freshmeat = null;
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

  // 객체 데이터를 임시 저장 데이터로 초기화 - step1
  Future<void> initMeatDataForStep1(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$path/basic-data');
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
    }
  }

  // 객체 데이터를 임시 저장 데이터로 초기화 - step 2
  Future<void> initMeatDataForStep2(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$path/additional-data');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);

      // 육류 추가 데이터
      freshmeat = data['freshmeat'];
      deepAging = data['deepAging'];
      heatedmeat = data['heatedmeat'];
      tongueData = data['tongueData'];
      labData = data['labData'];
    }
  }

  // 임시저장 데이터 저장 - step 1
  Future<void> saveTempDataForStep1() async {
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
    };
    await saveDataToLocal(tempData, '${userId!}/basic-data');
  }

  // 임시저장 데이터 저장 - step 2
  Future<void> saveTempDataForStep2() async {
    // 데이터 생성
    Map<String, dynamic> tempData = {
      // 육류 추가 데이터
      'freshmeat': freshmeat,
      'deepAging': deepAging,
      'heatedmeat': heatedmeat,
      'tongueData': tongueData,
      'labData': labData,
    };
    await saveDataToLocal(tempData, '${userId!}/additional-data');
  }

  // 임시저장 데이터 리셋 - step 1
  Future<void> resetTempDataForStep1() async {
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
    };

    await saveDataToLocal(tempData, '${userId!}/basic-data');
  }

  // 임시저장 데이터 리셋 - step 2
  Future<void> resetTempDataForStep2() async {
    // 데이터 생성
    Map<String, dynamic> tempData = {
      // 육류 추가 데이터
      'freshmeat': null,
      'deepAging': null,
      'heatedmeat': null,
      'tongueData': null,
      'labData': null,
    };

    await saveDataToLocal(tempData, '${userId!}/additional-data');
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

  // 신선육 데이터를 json 형식으로 변환
  String convertFreshMeatToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'freshmeat': freshmeat,
    };
    return jsonEncode(jsonData);
  }

  // 딥에징 데이터를 json 형식으로 변환
  String convertDeepAgingToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'deepAging': deepAging,
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

  // probexpt 데이터 생성
  Map<String, dynamic> _getProbexpt() {
    Map<String, dynamic> probexpt = {};

    if (tongueData != null && labData != null) {
      probexpt['createdAt'] = createdAt;
      probexpt['userId'] = userId;
      probexpt['period'] = getPeriod();
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

  // period
  int getPeriod() {
    int period = 0;
    if (deepAging != null && deepAging!.isNotEmpty) {
      DateTime givenDate = DateFormat('yyyy/MM/dd').parse(deepAging!.last);
      Duration difference = givenDate.difference(DateTime.now());
      period = difference.inDays;
    }
    return period;
  }
}
