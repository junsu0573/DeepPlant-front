import 'package:flutter/material.dart';
import 'package:deep_plant_app/source/meat_info_source.dart';
import 'package:deep_plant_app/source/widget_source.dart';

class InsertionMeatInfoPage extends StatefulWidget {
  const InsertionMeatInfoPage({super.key});

  @override
  State<InsertionMeatInfoPage> createState() => _InsertionMeatInfoPageState();
}

class _InsertionMeatInfoPageState extends State<InsertionMeatInfoPage> {
  MeatInfoSource source = MeatInfoSource();
  List<String>? largeData;
  List<List<String>>? tableData;

  String? selectedOrder; // -> 소, 돼지의 실질적 텍스트
  int orderNum = 0; // -> 소, 돼지의 편의적 정수
  bool isselectedorder = false; // -> 완료 되었는지를 확인

  String? selectedLarge; // -> 선택된 종류에 대한 대분류 텍스트
  int largeNum = 0; // -> 선택된 분류에 대한 편의적 수
  bool isselectedlarge = false; // -> 완료 되었는지를 확인

  String? selectedLittle; // -> 선택된 종류에 대한 소분류 텍스트
  int littleNum = 0; // -> 선택된 분류에 대한 편의적 수

  String? finalNumber; // -> 모든 선택 이후에 만들게 될 텍스트
  bool isFinal = false; // -> 모든 선택이 완료되었는지에 대한 분류

  void setOrder(String order, Source) {
    if (order == '소') {
      orderNum = 0;
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
      largeData = source.largeOrders_1;
    } else if (order == '돼지') {
      orderNum = 1;
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
      largeData = source.largeOrders_2;
    }
  }

  void setLarge(String large, MeatInfoSource source) {
    for (int i = 0; i < largeData!.length; i++) {
      if (large == largeData![i]) {
        largeNum = i;
        isselectedlarge = true;
        selectedLittle = null;
        finalNumber = null;
        isFinal = false;
        tableData = (orderNum == 0 ? source.tableData_1 : source.tableData_2);
        littleNum = 0;
        break;
      }
    }
  }

  void setLittle(String little, MeatInfoSource source) {
    for (int i = 0; i < tableData!.length; i++) {
      if (little == tableData![largeNum][i]) {
        littleNum = i;
        isFinal = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> orders = source.orders;
    List<String> largeOrders_1 = source.largeOrders_1;
    List<String> largeOrders_2 = source.largeOrders_2;
    List<List<String>> tableData_1 = source.tableData_1;
    List<List<String>> tableData_2 = source.tableData_2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.black,
        actions: [
          elevated(
            colorb: Colors.white,
            colori: Colors.black,
            icon: Icons.close,
            size: 30.0,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '육류 정보 입력',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    Text(
                      '종류',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: DropdownButton(
                    padding: EdgeInsets.only(left: 25.0),
                    alignment: Alignment.center,
                    elevation: 1,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10.0),
                    dropdownColor: Colors.white,
                    iconSize: 25.0,
                    isExpanded: true,
                    hint: Text('종류 선택'),
                    iconEnabledColor: Colors.grey[400],
                    value: selectedOrder,
                    items: orders
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Center(
                                  child: Text(
                                e,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOrder = value!;
                        setOrder(selectedOrder!, source);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    Text(
                      '부위',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: DropdownButton(
                      padding: EdgeInsets.only(left: 25.0),
                      underline: Container(),
                      menuMaxHeight: 250.0,
                      alignment: Alignment.center,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(10.0),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      hint: Text('대부위 선택'),
                      iconEnabledColor: Colors.grey[400],
                      value: selectedLarge,
                      items: (orderNum == 0 ? largeOrders_1 : largeOrders_2)
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Center(
                                    child: Text(
                                  e,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ))
                          .toList(),
                      onChanged: isselectedorder
                          ? (value) {
                              setState(() {
                                selectedLarge = value as String;
                                setLarge(selectedLarge!, source);
                              });
                            }
                          : null),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: DropdownButton(
                      padding: EdgeInsets.only(left: 25.0),
                      underline: Container(),
                      menuMaxHeight: 250.0,
                      alignment: Alignment.center,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(10.0),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      hint: Text('소부위 선택'),
                      iconEnabledColor: Colors.grey[400],
                      value: selectedLittle,
                      items: (orderNum == 0 ? tableData_1[largeNum] : tableData_2[largeNum])
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Center(
                                    child: Text(
                                  e,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ))
                          .toList(),
                      onChanged: isselectedlarge
                          ? (value) {
                              setState(() {
                                selectedLittle = value as String;
                                setLittle(selectedLittle!, source);
                              });
                            }
                          : null),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Transform.translate(
                  offset: Offset(0, 0),
                  child: SizedBox(
                    height: 55,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: isFinal ? () => {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        disabledBackgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('다음'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
