import 'package:flutter/material.dart';

class MeatModel with ChangeNotifier {
  String? userId;

  // 관리 번호 생성 시 저장
  String? id;
  String? createUser;
  String? createdAt;

  // 육류 오픈 API 데이터
  String? traceNum;
  String? farmAddr;
  String? farmerNm;
  String? butcheryYmd;
  String? birthYmd;
  String? sexType;
  String? gradeNum;

  // 육류 추가 정보
  String? speciesValue;
  String? primalValue;
  String? secondaryValue;

  // 육류 이미지 경로
  String? imagePath;
  String? heatedImage;
  String? deepAgedImage;

  // 딥에이징 차수
  int? seqno;

  // 신선육 관능평가 데이터
  Map<String, dynamic>? freshmeat;
  Map<String, dynamic>? deepAgedFreshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  List<String>? deepAging;
  Map<String, dynamic>? heatedmeat;
  Map<String, dynamic>? labData;
  Map<String, dynamic>? tongueData;

  Map<String, dynamic>? processedmeat;
  Map<String, dynamic>? rawmeat;

  // 데이터 입력 완료 체크
  bool? rawmeatDataComplete;
  List<bool>? processedmeatDataComplete;

  // Constructor
  MeatModel({
    // 관리 번호 생성 시 저장
    this.id,
    this.createUser,
    this.userId,
    this.createdAt,
    this.traceNum,
    this.farmAddr,
    this.farmerNm,
    this.butcheryYmd,
    this.birthYmd,
    this.sexType,
    this.gradeNum,
    this.speciesValue,
    this.primalValue,
    this.secondaryValue,
    this.imagePath,
    this.heatedImage,
    this.deepAgedImage,
    this.seqno,
    this.freshmeat,
    this.deepAgedFreshmeat,

    // 연구 데이터 추가 입력 완료 시 저장
    this.deepAging,
    this.heatedmeat,
    this.tongueData,
    this.labData,

    // 데이터 fetch 시 저장
    this.processedmeat,
    this.rawmeat,

    // // 데이터 입력 완료시 저장
    this.rawmeatDataComplete,
    this.processedmeatDataComplete,
  });

  // Data fetch
  void fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    createUser = jsonData['createUser'];
    userId = jsonData['userId'];
    createdAt = jsonData['createdAt'];
    traceNum = jsonData['traceNum'];
    farmAddr = jsonData['farmAddr'];
    farmerNm = jsonData['farmerNm'];
    butcheryYmd = jsonData['butcheryYmd'];
    birthYmd = jsonData['birthYmd'];
    sexType = jsonData['sexType'];
    gradeNum = jsonData['gradeNum'];
    speciesValue = jsonData['speciesValue'];
    primalValue = jsonData['primalValue'];
    secondaryValue = jsonData['secondaryValue'];
    imagePath = jsonData['imagePath'];
    heatedImage = jsonData['heatedImage'];
    deepAgedImage = jsonData['deepAgedImage'];
    seqno = jsonData['seqno'];
    freshmeat = jsonData['freshmeat'];
    deepAgedFreshmeat = jsonData['deepAgedFreshmeat'];

    // 연구 데이터 추가 입력 완료 시 저장
    deepAging = jsonData['deepAging'];
    heatedmeat = jsonData['heatedmeat'];
    tongueData = jsonData['tongueData'];
    labData = jsonData['labData'];

    // 데이터 fetch 시 저장
    processedmeat = jsonData['processedmeat'];
    rawmeat = jsonData['rawmeat'];

    // // 데이터 입력 완료시 저장
    rawmeatDataComplete = jsonData['rawmeatDataComplete'];
    processedmeatDataComplete = jsonData['processedmeatDataComplete'];
  }

  // Data reset
  void reset() {
    id = null;
    createUser = null;
    userId = null;
    createdAt = null;
    traceNum = null;
    farmAddr = null;
    farmerNm = null;
    butcheryYmd = null;
    birthYmd = null;
    sexType = null;
    gradeNum = null;
    speciesValue = null;
    primalValue = null;
    secondaryValue = null;
    imagePath = null;
    heatedImage = null;
    deepAgedImage = null;
    seqno = null;
    freshmeat = null;
    deepAgedFreshmeat = null;

    // 연구 데이터 추가 입력 완료 시 저장
    deepAging = null;
    heatedmeat = null;
    tongueData = null;
    labData = null;

    // 데이터 fetch 시 저장
    processedmeat = null;
    rawmeat = null;

    // // 데이터 입력 완료시 저장
    rawmeatDataComplete = null;
    processedmeatDataComplete = null;
  }
}
