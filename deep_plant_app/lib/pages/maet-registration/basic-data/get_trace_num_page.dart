import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:flutter/material.dart';

import 'package:deep_plant_app/source/oepn_api_source.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class GetTraceNum extends StatefulWidget {
  final MeatData meatData;
  GetTraceNum({
    super.key,
    required this.meatData,
  });

  @override
  State<GetTraceNum> createState() => _GetTraceNumState();
}

class _GetTraceNumState extends State<GetTraceNum> {
  var apikey =
      "%2FuEP%2BvIjYfPTyaHNlxRx2Ry5cVUer92wa6lHcxnXEEekVjUCZ1N41traj3s8sGhHpKS54SVDbg9m4sHOEuMNuw%3D%3D";

  final formkey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  RegExp input = RegExp(r'^[0-9L]+$');

  bool isNull = false;

  bool isFinal = false;
  bool isValue = false;
  String? traceNum;
  String? birthYmd;
  String? lsType;
  String? sexType;
  String? farmerNm;
  String? farmAddr;
  String? butcheryYmd;
  String? gradeNum;

  final List<String?> tableData = [];

  final List<String> baseData = [
    '이력번호',
    '출생년월일',
    '육종/축종',
    '성별',
    '경영자',
    '사육지',
    '도축일자',
    '등급',
  ];

  @override
  void initState() {
    super.initState();
  }

  void reset() {
    tableData.clear();
    traceNum = null;
    birthYmd = null;
    lsType = null;
    sexType = null;
    farmerNm = null;
    farmAddr = null;
    butcheryYmd = null;
    gradeNum = null;
  }

  void _tryValidation() {
    final isValid = formkey.currentState!.validate();
    if (isValid) {
      formkey.currentState!.save();
      isValue = true;
      isNull = false;
    } else {
      isValue = false;
      isFinal = false;
      isNull = false;
      tableData.clear();
    }
  }

  Future<void> fetchData(String historyNo) async {
    historyNo = historyNo.replaceAll(RegExp('\\s'), "");
    reset();

    if (historyNo.startsWith('L1')) {
      try {
        OpenApiSource source = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$historyNo&optionNo=9");

        final pigAPIData = await source.getJsonData();

        traceNum = pigAPIData['response']['body']['items']['item'][0]['pigNo'];
      } catch (e) {
        tableData.clear();
        isFinal = false;
      }
    } else {
      traceNum = historyNo;
    }

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

        lsType =
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
        tableData.clear();
        isFinal = false;
        // 여기에 다이얼로그로 수정!!
      }
    } else {
      try {
        OpenApiSource source4 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=4");
        OpenApiSource source3 = OpenApiSource(
            baseUrl:
                "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNum&optionNo=3");

        final meatAPIData4 = await source4.getJsonData();
        final meatAPIData3 = await source3.getJsonData();

        gradeNum =
            meatAPIData4['response']['body']['items']['item']['gradeNm'] ?? "";

        String? time = meatAPIData3['response']['body']['items']['item']
                ['butcheryYmd'] ??
            "";
        butcheryYmd = DateFormat('yyyyMMdd')
            .format(DateTime.parse(time!))
            .toString(); // 여기 형식을 yyyyMMdd로 변경

        lsType = '돼지';
      } catch (e) {
        tableData.clear();
        isFinal = false;
        // 여기에 다이얼로그로 수정!!
      }
    }
    if (butcheryYmd != null) {
      tableData.addAll([
        traceNum,
        birthYmd,
        lsType,
        sexType,
        farmerNm,
        farmAddr,
        butcheryYmd,
        gradeNum
      ]);
      isFinal = true;
      isNull = false;
    } else {
      isFinal = false;
      isNull = true;
    }
  }

  // 육류 정보 저장
  void saveMeatData() {
    widget.meatData.traceNum = traceNum;
    widget.meatData.farmAddr = farmAddr;
    widget.meatData.farmerNm = farmerNm;
    widget.meatData.butcheryYmd = butcheryYmd;
    widget.meatData.birthYmd = birthYmd;
    widget.meatData.sexType = sexType;
    widget.meatData.lsType = lsType;
    widget.meatData.gradeNum = gradeNum;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: '',
          backButton: false,
          closeButton: true,
        ),
        body: Column(
          children: [
            Text(
              '이력번호 입력',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 49.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formkey,
                  child: TextInsertionField(
                    controller: textEditingController,
                    validateFunc: (value) {
                      if (value!.isEmpty || value.length < 12) {
                        // 임시 지정!!
                        return "유효하지 않습니다!";
                      } else {
                        return null;
                      }
                    },
                    onSaveFunc: (value) {
                      traceNum = value!;
                    },
                    onChangeFunc: (value) {
                      traceNum = value;
                    },
                    mainText: '이력번호/묶음번호 입력',
                    width: 479.w,
                    height: 85.h,
                    maxLength: 15,
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                CommonButton(
                  text: Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPress: () async {
                    tableData.clear();
                    _tryValidation();
                    if (isValue) {
                      await fetchData(traceNum!);
                    }
                    setState(() {
                      FocusScope.of(context).unfocus();
                      textEditingController.clear();
                    });
                  },
                  width: 161.w,
                  height: 85.h,
                  bgColor: Palette.mainButtonColor,
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            if (isFinal == true)
              Expanded(child: View(tableData: tableData, baseData: baseData))
            else if (isNull == true)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 45.0,
                    ),
                    child: Text(
                      '검색결과가 없습니다',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              )
            else if (isFinal == false)
              Spacer(
                flex: 2,
              ),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: SaveButton(
                isWhite: false,
                text: '다음',
                width: 658.w,
                heigh: 104.h,
                onPressed: (isFinal && !isNull)
                    ? () {
                        saveMeatData();
                        context.go('/option/show-step/insert-meat-info');
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  const View({super.key, required this.tableData, required this.baseData});

  final List<String?> tableData;
  final List<String> baseData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: baseData.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  height: 45.0,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                            child: SizedBox(
                              width: 10,
                            ),
                          ),
                          TextSpan(
                            text: baseData[index],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  height: 45.0,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.25,
                    ),
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                            child: SizedBox(
                              width: 15,
                            ),
                          ),
                          TextSpan(
                            text: tableData[index],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
