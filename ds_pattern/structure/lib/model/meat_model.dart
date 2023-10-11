import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:structure/config/userfuls.dart';
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

  // 데이터 입력 완료 체크
  bool? rawmeatDataComplete;
  Map<String, dynamic>? processedmeatDataComplete;

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
    // seqno = jsonData['seqno'];

    freshmeat = jsonData['rawmeat']['sensory_eval'];
    // deepAgedFreshmeat = jsonData['deepAgedFreshmeat'];
    statusType = jsonData['statusType'];

    // 연구 데이터 추가 입력 완료 시 저장
    // deepAging = jsonData['deepAging'];
    // heatedmeat = jsonData['heatedmeat'];
    //tongueData = jsonData['tongueData'];
    //labData = jsonData['labData'];

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
    }
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
      "createdAt": Usefuls.getCurrentDate(),
      "userId": userId,
      "period": Usefuls.getMeatPeriod(this),
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
        "createdAt": Usefuls.getCurrentDate(),
        "userId": userId,
        "period": Usefuls.getMeatPeriod(this),
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
        "createdAt": Usefuls.getCurrentDate(),
        "userId": userId,
        "period": Usefuls.getMeatPeriod(this),
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
      "createdAt": Usefuls.getCurrentDate(),
      "userId": userId,
      "seqno": seqno,
      "period": Usefuls.getMeatPeriod(this),
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
      "updatedAt": Usefuls.getCurrentDate(),
      "userId": userId,
      "seqno": seqno,
      "period": Usefuls.getMeatPeriod(this),
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
  }

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
