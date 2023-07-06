import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';

import 'package:deep_plant_app/source/api_source.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class GetHistoryPage extends StatefulWidget {
  final MeatData meatData;
  GetHistoryPage({
    super.key,
    required this.meatData,
  });

  @override
  State<GetHistoryPage> createState() => _GetHistoryPageState();
}

class _GetHistoryPageState extends State<GetHistoryPage> {
  var apikey = "%2FuEP%2BvIjYfPTyaHNlxRx2Ry5cVUer92wa6lHcxnXEEekVjUCZ1N41traj3s8sGhHpKS54SVDbg9m4sHOEuMNuw%3D%3D";

  final formkey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  RegExp input = RegExp(r'^[0-9L]+$');

  bool isFinal = false;
  bool isValue = false;
  String? traceNo;
  String? birthYmd;
  String? lsType;
  String? sexNm;
  String? farmerNmfarmNo;
  String? farmAddr;
  String? butcheryYmd;
  String? insfat;
  String? gradeNm;

  final List<String?> tableData = [];

  final List<String> baseData = [
    '이력번호',
    '출생년월일',
    '육종/축종',
    '성별',
    '경영자',
    '사육지',
    '도축일자',
    '근내지방도',
    '등급',
  ];

  @override
  void initState() {
    super.initState();
  }

  void reset() {
    tableData.clear();
    traceNo = null;
    birthYmd = null;
    lsType = null;
    sexNm = null;
    farmerNmfarmNo = null;
    farmAddr = null;
    butcheryYmd = null;
    insfat = null;
    gradeNm = null;
  }

  void _tryValidation() {
    final isValid = formkey.currentState!.validate();
    if (isValid) {
      formkey.currentState!.save();
      isValue = true;
    } else {
      isValue = false;
      isFinal = false;
      tableData.clear();
    }
  }

  Future<void> fetchData(String historyNo) async {
    historyNo = historyNo.replaceAll(RegExp('\\s'), "");
    reset();

    if (historyNo.startsWith('L1')) {
      try {
        ApiSource source =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$historyNo&optionNo=9");

        final pigAPIData = await source.getJsonData();

        traceNo = pigAPIData['response']['body']['items']['item'][0]['pigNo'];
      } catch (e) {
        tableData.clear();
        isFinal = false;
      }
    } else {
      traceNo = historyNo;
    }

    if (traceNo!.startsWith('0')) {
      try {
        ApiSource source1 =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo&optionNo=1");
        ApiSource source2 =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo&optionNo=2");
        ApiSource source3 =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo&optionNo=3");

        final meatAPIData1 = await source1.getJsonData();
        final meatAPIData2 = await source2.getJsonData();
        final meatAPIData3 = await source3.getJsonData();

        String date = meatAPIData1['response']['body']['items']['item']['birthYmd'];
        birthYmd = DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString();
        lsType = meatAPIData1['response']['body']['items']['item']['lsTypeNm'] ?? "";
        sexNm = meatAPIData1['response']['body']['items']['item']['sexNm'] ?? "";
        String? farmerNm = meatAPIData2['response']['body']['items']['item'][0]['farmerNm'] ?? "";
        String? farmNo = meatAPIData2['response']['body']['items']['item'][0]['farmNo'] ?? "";
        farmerNmfarmNo = '$farmerNm($farmNo)';
        farmAddr = meatAPIData2['response']['body']['items']['item'][0]['farmAddr'] ?? "";
        String butDate = meatAPIData3['response']['body']['items']['item']['butcheryYmd'] ?? "";
        butcheryYmd = DateFormat('yyyy-MM-dd').format(DateTime.parse(butDate)).toString();
        insfat = meatAPIData3['response']['body']['items']['item']['insfat'] ?? "";
        gradeNm = meatAPIData3['response']['body']['items']['item']['gradeNm'] ?? "";
      } catch (e) {
        tableData.clear();
        isFinal = false;
        // 여기에 다이얼로그로 수정!!
      }
    } else {
      try {
        ApiSource source4 =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo&optionNo=4");
        ApiSource source3 =
            ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo&optionNo=3");

        final meatAPIData4 = await source4.getJsonData();
        final meatAPIData3 = await source3.getJsonData();

        gradeNm = meatAPIData4['response']['body']['items']['item']['gradeNm'] ?? "";
        String time = meatAPIData3['response']['body']['items']['item']['butcheryYmd'];
        butcheryYmd = DateFormat('yyyy-MM-dd').format(DateTime.parse(time)).toString();
        lsType = '돼지';
      } catch (e) {
        tableData.clear();
        isFinal = false;
        // 여기에 다이얼로그로 수정!!
      }
    }
    tableData.addAll([traceNo, birthYmd, lsType, sexNm, farmerNmfarmNo, farmAddr, butcheryYmd, insfat, gradeNm]);
    isFinal = true;
  }

  void saveData() {
    // 여기에서 tableData 요소를 담아서 넘기셈.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: '', backButton: false, closeButton: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.barcode_reader,
                        size: 30.0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                  child: Text(
                    '이력번호 입력',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Opacity(opacity: 0, child: IconButton(onPressed: null, icon: Icon(Icons.barcode_reader))),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: formkey,
                      child: TextFormField(
                        controller: textEditingController,
                        maxLength: 15,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 12) {
                            // 임시 지정!!
                            return "유효하지 않습니다!";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          traceNo = value!;
                        },
                        onChanged: (value) {
                          traceNo = value;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                )),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                )),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                )),
                            hintText: '이력번호나 묶음번호 입력',
                            contentPadding: EdgeInsets.all(12.0),
                            fillColor: Colors.grey[200],
                            filled: true),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: SizedBox(
                      height: 45,
                      width: 85,
                      child: ElevatedButton(
                        onPressed: () async {
                          tableData.clear();
                          _tryValidation();
                          if (isValue) {
                            await fetchData(traceNo!);
                          }
                          setState(() {
                            FocusScope.of(context).unfocus();
                            textEditingController.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: Text('검색'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  )
                ]),
              ],
            ),
            SizedBox(
              height: 5.0,
              width: 350.0,
            ),
            if (isFinal == true)
              Expanded(child: View(tableData: tableData, baseData: baseData))
            else
              Spacer(
                flex: 2,
              ),
            SaveButton(
              isWhite: false,
              text: '다음',
              width: 658.w,
              heigh: 104.h,
              onPressed: isFinal
                  ? () {
                      saveData();
                      context.go('/option/show-step/insert-meat-info');
                    }
                  : null,
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
