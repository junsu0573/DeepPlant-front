import 'dart:convert';
import 'dart:io';

import 'package:deep_plant_app/source/get_date.dart';
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
  Map<String, dynamic>? tongueData;
  Map<String, dynamic>? labData;

  Map<String, dynamic>? processedmeat;
  Map<String, dynamic>? rawmeat;

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
    gradeNum = null;
    speciesValue = null;
    primalValue = null;
    secondaryValue = null;
    imagePath = null;
    freshmeat = null;
    seqno = null;
  }

  // 임시 데이터를 로컬 임시 파일로 저장
  Future<void> saveDataToLocal(Map<String, dynamic> data, String path) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$path.json');

      // 파일을 저장할 디렉토리가 없으면 새로 생성
      await Directory(directory.path).create(recursive: true);

      await file.writeAsString(jsonEncode(data));
      print('임시저장 성공');
    } catch (e) {
      print('임시저장 실패: $e');
    }
  }

  // 객체 데이터를 임시 저장 데이터로 초기화
  Future<void> initMeatData(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$path/basic-data.json');
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
      gradeNum = data['gradeNum'];

      // 육류 추가 정보
      speciesValue = data['speciesValue'];
      primalValue = data['primalValue'];
      secondaryValue = data['secondaryValue'];

      // 육류 이미지 경로
      imagePath = data['imagePath'];

      // 신선육 관능평가
      freshmeat = data['freshmeat'];

      print('임시저장 데이터 fetch 성공');
    } else {
      print('임시저장 데이터 없음');
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

  // 신규 육류 데이터를 json 형식으로 변환
  String convertNewMeatToJson() {
    Map<String, dynamic> jsonData = {
      "id": id,
      "userId": userId,
      "createdAt": GetDate.getCurrentDate(),
      "traceNum": traceNum,
      "farmAddr": farmAddr,
      "farmerNm": farmerNm,
      "butcheryYmd": butcheryYmd,
      "birthYmd": birthYmd,
      "sexType": sexType,
      "gradeNum": gradeNum,
      "specieValue": speciesValue,
      "primalValue": primalValue,
      "secondaryValue": secondaryValue,
    };
    print(jsonData);

    return jsonEncode(jsonData);
  }

  // 신선육 관능평가 데이터를 json 형식으로 변환
  String convertFreshMeatToJson() {
    Map<String, dynamic> jsonData = {
      "id": id,
      "createdAt": deepAgedFreshmeat?["createdAt"],
      "userId": userId,
      "period": deepAgedFreshmeat?["period"],
      "marbling": deepAgedFreshmeat?["marbling"],
      "color": deepAgedFreshmeat?["color"],
      "texture": deepAgedFreshmeat?["texture"],
      "surfaceMoisture": deepAgedFreshmeat?["surfaceMoisture"],
      "overall": deepAgedFreshmeat?["overall"],
      "seqno": seqno,
      "deepAging": _getDeepAging(seqno),
    };
    print(jsonData);

    return jsonEncode(jsonData);
  }

  // 딥에이징 데이터를 json 형식으로 변환
  String convertDeepAgingToJson() {
    Map<String, dynamic> jsonData = {
      "id": id,
      "createdAt": GetDate.getCurrentDate(),
      "userId": userId,
      "period": 0,
      "seqno": seqno,
      "deepAging": _getDeepAging(seqno),
    };
    print(jsonData);
    return jsonEncode(jsonData);
  }

  // 딥에이징 데이터
  Map? _getDeepAging(int? idx) {
    if (idx == null || idx == 0) {
      return null;
    }
    String inputString = deepAging![idx - 1];

    List<String> parts = inputString.split('/');

    String date = parts[0];
    int minute = int.parse(parts[1]);

    return {
      'date': date,
      'minute': minute,
    };
  }

  // 가열육 데이터를 json 형식으로 변환
  String convertHeatedMeatToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'createdAt': heatedmeat?['createdAt'],
      'userId': userId,
      'period': heatedmeat?['period'],
      'flavor': heatedmeat?['flavor'],
      'juiciness': heatedmeat?['juiciness'],
      'tenderness': heatedmeat?['tenderness'],
      'umami': heatedmeat?['umami'],
      'palability': heatedmeat!['palability'],
      'seqno': seqno,
    };

    return jsonEncode(jsonData);
  }

  // probexpt 데이터를 json 형식으로 변환
  String convertPorbexptToJson() {
    Map<String, dynamic> jsonData = {
      'id': id,
      'updatedAt': GetDate.getCurrentDate(),
      'userId': userId,
      'period': getPeriod(),
      'L': labData?['L'],
      'a': labData?['a'],
      'b': labData?['b'],
      'DL': labData?['DL'],
      'CL': labData?['CL'],
      'RW': labData?['RW'],
      'ph': labData?['ph'],
      'WBSF': labData?['WBSF'],
      'cardepsin_activity': labData?['cardepsin_activity'],
      'MFI': labData?['MFI'],
      'Collagen': labData?['Collagen'],
      'sourness': tongueData?['sourness'],
      'bitterness': tongueData?['bitterness'],
      'umami': tongueData?['umami'],
      'richness': tongueData?['richness'],
      'seqno': seqno,
    };
    print(jsonData);

    return jsonEncode(jsonData);
  }

  // period
  int getPeriod() {
    DateTime butcheryDate = DateTime.parse(butcheryYmd!);
    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(butcheryDate);
    int period = difference.inHours;
    if (period < 0) {
      return 0;
    }
    return period;
  }

  // 관리번호 데이터 fetch
  void fetchData(dynamic jsonData) {
    // 변수에 데이터 저장
    birthYmd = jsonData['birthYmd'];
    butcheryYmd = jsonData['butcheryYmd'];
    createdAt = jsonData['createdAt'];
    farmAddr = jsonData['farmAddr'];
    farmerNm = jsonData['farmerNm'];
    gradeNum = jsonData['gradeNum'];
    id = jsonData['id'];
    imagePath = jsonData['imagePath'];
    primalValue = jsonData['primalValue'];

    processedmeat = jsonData['processedmeat'];
    if (processedmeat != null && processedmeat!.isNotEmpty) {
      int entryCount = processedmeat!.length;
      List<String> tempDeepAging = [];
      for (int i = 1; i <= entryCount; i++) {
        Map<String, dynamic> temp = processedmeat!['$i회'];
        Map<String, dynamic> temp2 = temp['sensory_eval'];
        Map<String, dynamic> temp3 = temp2['deepaging_data'];

        tempDeepAging.add('${temp3['date']}/${temp3['minute']}');
      }
      deepAging = tempDeepAging;
    }

    rawmeat = jsonData['rawmeat'];

    secondaryValue = jsonData['secondaryValue'];
    sexType = jsonData['sexType'];
    speciesValue = jsonData['specieValue'];
    traceNum = jsonData['traceNum'];
    userId = jsonData['userId'];
  }

  // 원육 데이터 fetch
  void fetchDataForOrigin() {
    seqno = 0;
    Map<String, dynamic>? data = rawmeat;
    if (data == null) {
      heatedmeat = null;
    } else {
      // 실험데이터
      if (data['probexpt_data'] != null) {
        Map<String, dynamic> temp = data['probexpt_data'];
        tongueData = {
          'sourness': temp['sourness'],
          'bitterness': temp['bitterness'],
          'umami': temp['umami'],
          'richness': temp['richness'],
        };
        labData = {
          'L': temp['L'],
          'a': temp['a'],
          'b': temp['b'],
          'DL': temp['DL'],
          'CL': temp['CL'],
          'RW': temp['RW'],
          'ph': temp['ph'],
          'WBSF': temp['WBSF'],
          'cardepsin_activity': temp['cardepsin_activity'],
          'MFI': temp['MFI']
        };
      }
      // 가열육 데이터
      heatedmeat = data['heatedmeat_sensory_eval'];
      heatedImage = null;
      if (heatedmeat != null) {
        Map<String, dynamic> heatedTemp = data['heatedmeat_sensory_eval'];
        heatedImage = heatedTemp['imagePath'];
      }
    }
  }

  // 처리육 데이터 fetch
  void fetchDataForDeepAging() {
    Map<String, dynamic> data = processedmeat!['$seqno회'];

    // 신선육 데이터
    deepAgedFreshmeat = data['sensory_eval'];
    deepAgedImage = null;
    if (data['sensory_eval'] != null) {
      Map<String, dynamic> temp = data['sensory_eval'];
      deepAgedImage = temp['imagePath'];
    }

    // 가열육 데이터
    heatedmeat = data['heatedmeat_sensory_eval'];
    heatedImage = null;
    if (data['heatedmeat_sensory_eval'] != null) {
      Map<String, dynamic> temp = data['heatedmeat_sensory_eval'];
      heatedImage = temp['imagePath'];
    }

    // 실험데이터
    if (data['probexpt_data'] != null) {
      Map<String, dynamic> temp = data['probexpt_data'];
      tongueData = {
        'sourness': temp['sourness'],
        'bitterness': temp['bitterness'],
        'umami': temp['umami'],
        'richness': temp['richness'],
      };
      labData = {
        'L': temp['L'],
        'a': temp['a'],
        'b': temp['b'],
        'DL': temp['DL'],
        'CL': temp['CL'],
        'RW': temp['RW'],
        'ph': temp['ph'],
        'WBSF': temp['WBSF'],
        'cardepsin_activity': temp['cardepsin_activity'],
        'MFI': temp['MFI']
      };
    } else {
      tongueData = null;
      labData = null;
    }
  }
}
