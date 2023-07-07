import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:deep_plant_app/source/api_source.dart';

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
  var apikey = "58%2FAb40DJd41UCVYmCZM89EUoOWqT0vuObbReDQCI6ufjHIJbhZOUtQnftZErMQf6%2FgEflZVctg97VfdvvtmQw%3D%3D";

  final formkey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  bool isFinal = false;
  bool isValue = false;
  String? historyNum;

  String? farmAdd;
  String? basetime;
  String? houseName;
  String? grade;

  final List<String> tableData = [];

  final List<String> baseData = [
    '이력번호',
    '농장',
    '도축장',
    '도축일자',
    '육종/축종',
    '성별',
    '등급',
    '출생년월일',
  ];

  @override
  void initState() {
    super.initState();
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

  Future<void> fetchData(String historyNum) async {
    var traceNo = historyNum;
    tableData.clear();

    try {
      ApiSource source = ApiSource(baseUrl: "http://data.ekape.or.kr/openapi-data/service/user/animalTrace/traceNoSearch?serviceKey=$apikey&traceNo=$traceNo");

      final meatAPIData = await source.getJsonData();

      farmAdd = meatAPIData['response']['body']['items']['item'][1]['farmAddr'];
      houseName = meatAPIData['response']['body']['items']['item'][4]['butcheryPlaceNm'];
      basetime = meatAPIData['response']['body']['items']['item'][4]['butcheryYmd'];
      String basetimeResolve = DateFormat('yyyy-MM-dd').format(DateTime.parse(basetime!)).toString();
      String breeding = meatAPIData['response']['body']['items']['item'][0]['lsTypeNm'];
      String gender = meatAPIData['response']['body']['items']['item'][0]['sexNm'];
      grade = meatAPIData['response']['body']['items']['item'][4]['gradeNm'];
      String birth = meatAPIData['response']['body']['items']['item'][0]['birthYmd'];
      String birthResolve = DateFormat('yyyy-MM-dd').format(DateTime.parse(birth)).toString();

      tableData.addAll([traceNo, farmAdd!, houseName!, basetimeResolve, breeding, gender, grade!, birthResolve]);

      isFinal = true;
    } catch (e) {
      tableData.clear();
      isFinal = false;
      // 여기에 다이얼로그로 수정!!
    }
  }

  void saveData() {
    widget.meatData.historyNumber = historyNum;
    widget.meatData.gradeNm = grade;
    widget.meatData.farmAddr = farmAdd;
    widget.meatData.butcheryPlaceNm = houseName;
    widget.meatData.butcheryYmd = basetime;
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
            Text(
              '이력번호 입력',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
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
                        maxLength: 12,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 12) {
                            // 임시 지정!!
                            return "유효하지 않습니다!";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          historyNum = value!;
                        },
                        onChanged: (value) {
                          historyNum = value;
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
                            hintText: '이력번호 입력',
                            contentPadding: EdgeInsets.all(12.0),
                            fillColor: Colors.grey[200],
                            filled: true),
                        keyboardType: TextInputType.number,
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
                            await fetchData(historyNum!);
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Transform.translate(
                offset: Offset(0, 0),
                child: SizedBox(
                  height: 55,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: isFinal
                        ? () {
                            saveData();
                            context.go('/option/show-step/insert-meat-info');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        disabledBackgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    child: Text('다음'),
                  ),
                ),
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

  final List<String> tableData;
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
