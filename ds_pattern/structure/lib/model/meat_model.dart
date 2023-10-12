import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:structure/main.dart';

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
  String? deepAgedImage;

  // 딥에이징 차수
  int? seqno;

  // 데이터 승인상태
  String? statusType;

  // 신선육 관능평가 데이터
  Map<String, dynamic>? freshmeat;
  Map<String, dynamic>? deepAgedFreshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  List<Map<String, dynamic>>? deepAgingData;
  Map<String, dynamic>? heatedmeat;
  Map<String, dynamic>? probexptData;

  Map<String, dynamic>? processedmeat;
  Map<String, dynamic>? rawmeat;

  // 외부 데이터 입력 완료 체크
  bool? rawmeatDataComplete;
  Map<String, dynamic>? processedmeatDataComplete;

  // 내부 데이터 입력 완료 체크
  bool basicCompleted = false;
  bool freshImageCompleted = false;
  bool deepAgedImageCompleted = false;
  bool rawFreshCompleted = false;
  bool deepAgedFreshCompleted = false;
  bool heatedCompleted = false;
  bool tongueCompleted = false;
  bool labCompleted = false;

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
    this.deepAgedImage,
    this.seqno,
    this.freshmeat,
    this.deepAgedFreshmeat,
    this.statusType,

    // 연구 데이터 추가 입력 완료 시 저장
    this.deepAgingData,
    this.heatedmeat,
    this.probexptData,

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
    createUser = jsonData['userId'];
    createdAt = jsonData['createdAt'];
    traceNum = jsonData['traceNum'];
    farmAddr = jsonData['farmAddr'];
    farmerNm = jsonData['farmerNm'];
    butcheryYmd = jsonData['butcheryYmd'];
    birthYmd = jsonData['birthYmd'];
    sexType = jsonData['sexType'];
    gradeNum = jsonData['gradeNum'];
    speciesValue = jsonData['specieValue'];
    primalValue = jsonData['primalValue'];
    secondaryValue = jsonData['secondaryValue'];
    imagePath = jsonData['rawmeat']['sensory_eval']['imagePath'];
    // deepAgedImage = jsonData['deepAgedImage'];

    freshmeat = jsonData['rawmeat']['sensory_eval'];
    // deepAgedFreshmeat = jsonData['deepAgedFreshmeat'];
    statusType = jsonData['statusType'];

    // 딥에이징 데이터 입력시 저장
    // heatedmeat = jsonData['heatedmeat'];
    // tongueData = jsonData['tongueData'];
    // labData = jsonData['labData'];

    // 데이터 fetch 시 저장
    processedmeat = jsonData['processedmeat'];
    rawmeat = jsonData['rawmeat'];

    // 데이터 입력 완료시 저장
    rawmeatDataComplete = jsonData['rawmeat_data_complete'];
    processedmeatDataComplete = jsonData['processedmeat_data_complete'] == false
        ? {}
        : jsonData['processedmeat_data_complete'];

    // 딥에이지 데이터
    deepAgingData = [];

    if (processedmeat != null && processedmeat!.isNotEmpty) {
      processedmeat!.forEach((key, value) {
        deepAgingData!.add({
          "deepAgingNum": key,
          "date": value["sensory_eval"]["deepaging_data"]["date"],
          "minute": value["sensory_eval"]["deepaging_data"]["minute"],
          "complete": processedmeatDataComplete![key]
        });
      });
    }

    // 완료 체크
    if (traceNum != null && speciesValue != null && secondaryValue != null) {
      basicCompleted = true;
    }
    if (imagePath != null) {
      freshImageCompleted = true;
    }
    if (freshmeat?['marbling'] != null &&
        freshmeat?['marbling'] != 0 &&
        freshmeat?['color'] != null &&
        freshmeat?['color'] != 0 &&
        freshmeat?['texture'] != null &&
        freshmeat?['texture'] != 0 &&
        freshmeat?['surfaceMoisture'] != null &&
        freshmeat?['surfaceMoisture'] != 0 &&
        freshmeat?['overall'] != null &&
        freshmeat?['overall'] != 0) {
      rawFreshCompleted = true;
    }
  }

  void fromJsonTemp(Map<String, dynamic> jsonData) {
    sexType = jsonData["sexType"];
    speciesValue = jsonData["specieValue"];
    primalValue = jsonData["primalValue"];
    secondaryValue = jsonData["secondaryValue"];
    gradeNum = jsonData["gradeNum"];
    traceNum = jsonData["traceNum"];
    farmAddr = jsonData["farmAddr"];
    farmerNm = jsonData["farmerNm"];
    butcheryYmd = jsonData["butcheryYmd"];
    birthYmd = jsonData["birthYmd"];
    imagePath = jsonData["iamgePath"];
    freshmeat = jsonData["freshmeat"];
  }

  void fromJsonAdditional(String deepAgingNum) {
    if (deepAgingNum == 'RAW') {
      heatedmeat = rawmeat?['heatedmeat_sensory_eval'];
      probexptData = rawmeat?['probexpt_data'];
    } else {
      deepAgedFreshmeat = processedmeat?[deepAgingNum]['sensory_eval'];
      deepAgedImage = deepAgedFreshmeat?['imagePath'];
      heatedmeat = processedmeat?[deepAgingNum]['heatedmeat_sensory_eval'];
      probexptData = processedmeat?[deepAgingNum]['probexpt_data'];
      // 완료 체크
      if (deepAgedImage != null) {
        deepAgedImageCompleted = true;
      }
      if (deepAgedFreshmeat?['marbling'] != null &&
          deepAgedFreshmeat?['marbling'] != 0 &&
          deepAgedFreshmeat?['color'] != null &&
          deepAgedFreshmeat?['color'] != 0 &&
          deepAgedFreshmeat?['texture'] != null &&
          deepAgedFreshmeat?['texture'] != 0 &&
          deepAgedFreshmeat?['surfaceMoisture'] != null &&
          deepAgedFreshmeat?['surfaceMoisture'] != 0 &&
          deepAgedFreshmeat?['overall'] != null &&
          deepAgedFreshmeat?['overall'] != 0) {
        deepAgedFreshCompleted = true;
      }
    }
    // 완료체크
    if (heatedmeat?['flavor'] != null &&
        heatedmeat?['flavor'] != 0 &&
        heatedmeat?['juiciness'] != null &&
        heatedmeat?['juiciness'] != 0 &&
        heatedmeat?['tenderness'] != null &&
        heatedmeat?['tenderness'] != 0 &&
        heatedmeat?['umami'] != null &&
        heatedmeat?['umami'] != 0 &&
        heatedmeat?['palability'] != null &&
        heatedmeat?['palability'] != 0) {
      heatedCompleted = true;
    }
    if (probexptData?['sourness'] != null &&
        probexptData?['bitterness'] != null &&
        probexptData?['umami'] != null &&
        probexptData?['richness'] != null) {
      tongueCompleted = true;
    }
    if (probexptData?["L"] != null &&
        probexptData?["a"] != null &&
        probexptData?["b"] != null &&
        probexptData?["DL"] != null &&
        probexptData?["CL"] != null &&
        probexptData?["RW"] != null &&
        probexptData?["ph"] != null &&
        probexptData?["WBSF"] != null &&
        probexptData?["cardepsin_activity"] != null &&
        probexptData?["MFI"] != null &&
        probexptData?["Collagen"] != null) {
      labCompleted = true;
    }
  }

  String toJsonTemp() {
    return jsonEncode({
      "sexType": sexType,
      "specieValue": speciesValue,
      "primalValue": primalValue,
      "secondaryValue": secondaryValue,
      "gradeNum": gradeNum,
      "traceNum": traceNum,
      "farmAddr": farmAddr,
      "farmerNm": farmerNm,
      "butcheryYmd": butcheryYmd,
      "birthYmd": birthYmd,
      "iamgePath": imagePath,
      "freshmeat": freshmeat,
    });
  }

  String toJsonBasic() {
    return jsonEncode({
      "id": id,
      "userId": userId,
      "sexType": sexType,
      "specieValue": speciesValue,
      "primalValue": primalValue,
      "secondaryValue": secondaryValue,
      "gradeNum": gradeNum,
      "createdAt": createdAt,
      "traceNum": traceNum,
      "farmAddr": farmAddr,
      "farmerNm": farmerNm,
      "butcheryYmd": butcheryYmd,
      "birthYmd": birthYmd,
    });
  }

  String toJsonFresh(Map<String, dynamic>? deepAging) {
    print({
      "id": id,
      "createdAt": freshmeat?["createdAt"],
      "userId": userId,
      "period": freshmeat?["period"],
      "marbling": freshmeat?["marbling"],
      "color": freshmeat?["color"],
      "texture": freshmeat?["texture"],
      "surfaceMoisture": freshmeat?["surfaceMoisture"],
      "overall": freshmeat?["overall"],
      "seqno": meatModel.seqno,
      "deepAging": deepAging,
    });
    if (deepAging == null) {
      return jsonEncode({
        "id": id,
        "createdAt": freshmeat?["createdAt"],
        "userId": userId,
        "period": freshmeat?["period"],
        "marbling": freshmeat?["marbling"],
        "color": freshmeat?["color"],
        "texture": freshmeat?["texture"],
        "surfaceMoisture": freshmeat?["surfaceMoisture"],
        "overall": freshmeat?["overall"],
        "seqno": meatModel.seqno,
        "deepAging": deepAging,
      });
    } else {
      return jsonEncode({
        "id": id,
        "createdAt": deepAgedFreshmeat?["createdAt"],
        "userId": userId,
        "period": deepAgedFreshmeat?["peiod"],
        "marbling": deepAgedFreshmeat?["marbling"],
        "color": deepAgedFreshmeat?["color"],
        "texture": deepAgedFreshmeat?["texture"],
        "surfaceMoisture": deepAgedFreshmeat?["surfaceMoisture"],
        "overall": deepAgedFreshmeat?["overall"],
        "seqno": meatModel.seqno,
        "deepAging": deepAging,
      });
    }
  }

  String toJsonHeated() {
    return jsonEncode({
      "id": id,
      "createdAt": heatedmeat?["createdAt"],
      "userId": userId,
      "seqno": seqno,
      "period": heatedmeat?["createdAt"],
      "flavor": heatedmeat?['flavor'],
      "juiciness": heatedmeat?['juiciness'],
      "tenderness": heatedmeat?['tenderness'],
      "umami": heatedmeat?['umami'],
      "palability": heatedmeat?['palability']
    });
  }

  String toJsonProbexpt() {
    return jsonEncode({
      "id": id,
      "updatedAt": probexptData?["updatedAt"],
      "userId": userId,
      "seqno": seqno,
      "period": probexptData?["period"],
      "L": probexptData?["L"],
      "a": probexptData?["a"],
      "b": probexptData?["b"],
      "DL": probexptData?["DL"],
      "CL": probexptData?["CL"],
      "RW": probexptData?["RW"],
      "ph": probexptData?["ph"],
      "WBSF": probexptData?["WBSF"],
      "cardepsin_activity": probexptData?["cardepsin_activity"],
      "MFI": probexptData?["MFI"],
      "Collagen": probexptData?["Collagen"],
      "sourness": probexptData?['sourness'],
      "bitterness": probexptData?['bitterness'],
      "umami": probexptData?['umami'],
      "richness": probexptData?['richness'],
    });
  }

  // Data reset
  void reset() {
    // userId을 제외한 모든 데아터 초기화
    id = null;
    createUser = null;
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
    deepAgedImage = null;
    seqno = null;
    freshmeat = null;
    deepAgedFreshmeat = null;
    statusType = null;

    // 연구 데이터 추가 입력 완료 시 저장
    deepAgingData = null;
    heatedmeat = null;
    probexptData = null;

    // 데이터 fetch 시 저장
    processedmeat = null;
    rawmeat = null;

    // // 데이터 입력 완료시 저장
    rawmeatDataComplete = null;
    processedmeatDataComplete = null;

    // 내부 데이터 입력 완료 체크
    basicCompleted = false;
    freshImageCompleted = false;
    deepAgedImageCompleted = false;
    rawFreshCompleted = false;
    deepAgedFreshCompleted = false;
    heatedCompleted = false;
    tongueCompleted = false;
    labCompleted = false;
  }

  // text code
  @override
  String toString() {
    return "id: $id,"
        // "createUser: $createUser,"
        // "userId: $userId,"
        // "createdAt: $createdAt,"
        // "traceNum: $traceNum,"
        // "farmAddr: $farmAddr,"
        // "farmerNm: $farmerNm,"
        // "butcheryYmd: $butcheryYmd,"
        // "birthYmd: $birthYmd,"
        // "sexType: $sexType,"
        // "gradeNum: $gradeNum,"
        // "speciesValue: $speciesValue,"
        // "primalValue: $primalValue,"
        // "secondaryValue: $secondaryValue,"
        // "imagePath: $imagePath,"
        // "deepAgedImage: $deepAgedImage,"
        "seqno: $seqno,"
        "freshmeat: $freshmeat,"
        "deepAgedFreshmeat: $deepAgedFreshmeat,"
        "statusType: $statusType,"

        // 연구 데이터 추가 입력 완료 시 저장
        "deepAging: $deepAgingData,"
        "heatedmeat: $heatedmeat,"
        "probexptData: $probexptData,"

        // 데이터 fetch 시 저장
        "processedmeat: $processedmeat,"
        "rawmeat: $rawmeat,"

        // // 데이터 입력 완료시 저장
        "rawmeatDataComplete: $rawmeatDataComplete,"
        "processedmeatDataComplete: $processedmeatDataComplete,";
  }
}
