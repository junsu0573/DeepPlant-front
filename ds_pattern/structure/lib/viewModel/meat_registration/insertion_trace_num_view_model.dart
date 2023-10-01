import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class InsertionTraceNumViewModel with ChangeNotifier {
  final MeatModel meatModel;
  InsertionTraceNumViewModel({required this.meatModel});

  // form
  final formKey = GlobalKey<FormState>();

  // api key
  var apikey =
      "%2FuEP%2BvIjYfPTyaHNlxRx2Ry5cVUer92wa6lHcxnXEEekVjUCZ1N41traj3s8sGhHpKS54SVDbg9m4sHOEuMNuw%3D%3D";

  // text controller
  final TextEditingController textEditingController = TextEditingController();

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
      fetchMeatData();
    }
  }

  // 객체에 값이 존재하면 fetch(api를 매번 호출하는 것 보다 빠름)
  void fetchMeatData() {
    traceNum = meatModel.traceNum;
    birthYmd = meatModel.birthYmd;
    species = meatModel.speciesValue;
    sexType = meatModel.sexType;
    farmerNm = meatModel.farmerNm;
    farmAddr = meatModel.farmAddr;
    butcheryYmd = meatModel.butcheryYmd;
    gradeNum = meatModel.gradeNum;
  }

  // api를 통해 얻어온 육류의 정보를 객체에 저장
  void saveMeatData() {
    meatModel.traceNum = traceNum;
    meatModel.farmAddr = farmAddr;
    meatModel.farmerNm = farmerNm;
    meatModel.butcheryYmd = butcheryYmd;
    meatModel.birthYmd = birthYmd;
    meatModel.sexType = sexType;
    meatModel.speciesValue = species;
    meatModel.gradeNum = gradeNum;
  }

  // 새롭게 검색을 누를 때, 기존 데이터 초기화(소와 돼지의 불러오는 값이 다르기에)
  void reset() {
    tableData.clear();
    traceNum = null;
    birthYmd = null;
    species = null;
    sexType = null;
    farmerNm = null;
    farmAddr = null;
    butcheryYmd = null;
    gradeNum = null;
  }

  String parsingData(String input) {
    RegExp regExp = RegExp(r'\[.*?\]\s*(.*)');
    Match? match = regExp.firstMatch(input);

    if (match != null) {
      return match.group(1)!;
    } else {
      return input;
    }
  }

  bool tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      return true;
    } else {
      reset();
      return false;
    }
  }

  void start(BuildContext context) async {
    FocusScope.of(context).unfocus();

    tableData.clear();
    bool isValid = tryValidation();

    if (isValid) {
      await fetchData(traceNum!);
    }

    textEditingController.clear();
    notifyListeners();
  }

  // fetchData
  Future<void> fetchData(String historyNo) async {
    historyNo = historyNo.replaceAll(RegExp('\\s'), "");
    reset();

    // 만일 묶음 번호가 들어온다면, 처리하여 이력 번호로 갱신한다.
    if (historyNo.startsWith('L1')) {
      try {
        OpenApiSource source = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$historyNo&optionNo=9");

        final pigAPIData = await source.getJsonData();

        if (pigAPIData['response']['body']['items']['item'][0] == null) {
          traceNum = pigAPIData['response']['body']['items']['item']['pigNo'];
        } else {
          traceNum =
              pigAPIData['response']['body']['items']['item'][0]['pigNo'];
        }
      } catch (e) {
        reset();
        isAllInserted = 2;
      }
    } else {
      traceNum = historyNo;
    }

    // 소의 경우이다.
    if (traceNum!.startsWith('0')) {
      try {
        OpenApiSource source1 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=1");
        OpenApiSource source2 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=2");
        OpenApiSource source3 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=3");

        final meatAPIData1 = await source1.getJsonData();
        final meatAPIData2 = await source2.getJsonData();
        final meatAPIData3 = await source3.getJsonData();

        String? date =
            meatAPIData1['response']['body']['items']['item']['birthYmd'] ?? "";
        birthYmd = DateFormat('yyyyMMdd')
            .format(DateTime.parse(date!))
            .toString(); // 여기 형식을 yyyyMMdd로 변경

        species =
            meatAPIData1['response']['body']['items']['item']['lsTypeNm'] ?? "";
        sexType = meatAPIData1['response']['body']['items']['item']['sexNm'] ??
            ""; // 이건 그대로 string으로 주면 됨

        farmerNm = meatAPIData2['response']['body']['items']['item'][0]
                ['farmerNm'] ??
            "";
        farmAddr = meatAPIData2['response']['body']['items']['item'][0]
                ['farmAddr'] ??
            "";

        String? butDate = meatAPIData3['response']['body']['items']['item']
                ['butcheryYmd'] ??
            "";
        butcheryYmd = DateFormat('yyyyMMdd')
            .format(DateTime.parse(butDate!))
            .toString(); // 여기 형식을 yyyyMMdd로 변경

        gradeNum =
            meatAPIData3['response']['body']['items']['item']['gradeNm'] ?? "";
      } catch (e) {
        reset();
        isAllInserted = 2;
      }
    } else {
      // 돼지의 경우이다.
      try {
        OpenApiSource source4 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=4");
        OpenApiSource source3 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=3");

        final meatAPIData4 = await source4.getJsonData();
        final meatAPIData3 = await source3.getJsonData();

        gradeNum = meatAPIData4['response']['body']['items']['item']['gradeNm'];

        String? time = meatAPIData3['response']['body']['items']['item']
                ['butcheryYmd'] ??
            "";
        butcheryYmd = DateFormat('yyyyMMdd')
            .format(DateTime.parse(time!))
            .toString(); // 여기 형식을 yyyyMMdd로 변경

        species = '돼지';
      } catch (e) {
        reset();
        isAllInserted = 2;
      }
    }
    if (butcheryYmd != null) {
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
    } else {
      isAllInserted = 2;
    }
  }

  // void asyncPaging() async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => InsertionMeatInfo(
  //         meatData: widget.meatData,
  //       ),
  //     ),
  //   );
  //   if (!mounted) return;
  //   Navigator.pop(context);
  // }
}
