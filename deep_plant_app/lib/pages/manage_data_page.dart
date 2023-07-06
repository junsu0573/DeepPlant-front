import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/data_page_toggle_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ManageData extends StatefulWidget {
  const ManageData({super.key});

  @override
  State<ManageData> createState() => _ManageDataState();
}

class _ManageDataState extends State<ManageData> {
  final TextEditingController search = TextEditingController();
  FocusNode focusNode = FocusNode();
  String text = '';
  final List<String> label = ['관리번호', '등록자', '관리'];
  final List<bool> _selections1 = [false, true, false, false];
  final List<bool> _selections2 = [true, false];
  String option1 = '1개월';
  String option2 = '최신순';
  bool isSelectedTable = false;

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  final List<String> userData = [
    '2022091911501022,박수현, ',
    '2022091911501022,박수현, ',
  ];

  _ManageDataState() {
    search.addListener(() {
      setState(() {
        text = search.text;
      });
    });
  }

  List<String> extractIds(List<dynamic> jsonData) {
    List<String> ids = [];
    for (var item in jsonData) {
      if (item is Map<String, dynamic> && item.containsKey('id')) {
        ids.add(item['id']);
      }
    }
    return ids;
  }

  @override
  void initState() {
    super.initState();
    fetchJsonData();
  }

  Future<void> fetchJsonData() async {
    var apiUrl = 'http://172.30.1.17:8080/user?id=junsu0573@naver.com';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['meatList'] as List<dynamic>;
        var ids = extractIds(jsonData);
        for (int i = 0; i < ids.length; i++) {
          userData.add('${ids[i]},전수현, ');
        }
      } else {
        // Error handling
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Exception handling
      print('Error: $e');
    }
  }

  void insertOption1(String option) {
    option1 = option;
  }

  void insertOption2(String option) {
    option2 = option;
  }

  void _dataColumnSort(int columnIndex, bool ascending) {}

  List<DataColumn> getColumns() {
    List<DataColumn> dataColumn = [];
    for (var i in label) {
      if (i == '관리번호') {
        dataColumn.add(
          DataColumn(
            label: Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
            numeric: true,
            onSort: _dataColumnSort,
          ),
        );
      } else if (i == '관리') {
        dataColumn.add(DataColumn(
            label: Padding(
                padding: EdgeInsets.only(left: 17.0),
                child: Text(
                  i,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ))));
      } else {
        dataColumn.add(DataColumn(
            label: Expanded(
                child: Text(
          i,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ))));
      }
    }
    return dataColumn;
  }

  List<DataRow> getRows() {
    List<String> source = userData;
    List<DataRow> dataRow = [];

    // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
    // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
    // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.
    List<String> filteredData = source.where((data) => data.contains(text)).toList();

    for (var i = 0; i < filteredData.length; i++) {
      var csvDataCells = filteredData[i].split(',');
      List<DataCell> cells = [];
      cells.add(DataCell(
        Container(
          width: 100,
          padding: EdgeInsets.only(right: 20.0),
          constraints: BoxConstraints(maxWidth: 100.0),
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.center,
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: csvDataCells[0],
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ));
      cells.add(DataCell(Text(
        csvDataCells[1],
        style: TextStyle(
          fontSize: 15.0,
        ),
      )));
      if (csvDataCells[1] == '전수현') {
        cells.add(DataCell(ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              )),
          child: Text(
            '수정',
          ),
        )));
      } else {
        cells.add(DataCell.empty);
      }

      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }

  Widget getDataTable() {
    return DataTable(
      showBottomBorder: true,
      headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
      headingRowHeight: 40.0,
      columns: getColumns(),
      rows: getRows(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '데이터 열람',
        backButton: true,
        closeButton: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 35.0,
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextField(
                            textAlign: TextAlign.end,
                            focusNode: focusNode,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 13.5,
                            ),
                            controller: search,
                            cursorColor: Colors.grey[400],
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                              hintText: '관리번호검색',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              suffixIcon: focusNode.hasFocus
                                  ? IconButton(
                                      onPressed: () {
                                        search.clear();
                                        text = '';
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.grey[400],
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search),
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 0.2, color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  )),
                            ))),
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            )),
                            builder: (BuildContext context) {
                              return !isSelectedTable
                                  ? Container(
                                      margin: EdgeInsets.all(18.0),
                                      height: 300,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              '조회기간',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            ToggleButton(
                                              insertOptionFunc: insertOption1,
                                              options: [
                                                Text('3일'),
                                                Text('1개월'),
                                                Text('3개월'),
                                                Text('직접설정'),
                                              ],
                                              isSelected: _selections1,
                                              isRadius: false,
                                              minHeight: 30.0,
                                              minWidth: 80.0,
                                            ),
                                            Text(
                                              '정렬',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            ToggleButton(
                                              insertOptionFunc: insertOption2,
                                              options: [
                                                Text('최신순'),
                                                Text('과거순'),
                                              ],
                                              isSelected: _selections2,
                                              isRadius: false,
                                              minHeight: 30.0,
                                              minWidth: 160.0,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey[800],
                                                disabledBackgroundColor: Colors.grey[400],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 55.0,
                                                child: Center(
                                                  child: Text(
                                                    '확인',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17.0,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : TableCalendar(
                                      locale: 'ko_KR',
                                      firstDay: DateTime.utc(2022, 1, 1),
                                      lastDay: DateTime.utc(2023, 12, 31),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: false,
                                        titleCentered: true,
                                        titleTextStyle: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        leftChevronMargin: EdgeInsets.only(left: 85.0, top: 5.0),
                                        rightChevronMargin: EdgeInsets.only(right: 85.0, top: 5.0),
                                      ),
                                      calendarStyle: CalendarStyle(
                                        outsideDaysVisible: false,
                                        cellMargin: EdgeInsets.all(0),
                                        todayDecoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        selectedDecoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      focusedDay: focusedDay,
                                      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                                        // 선택된 날짜의 상태를 갱신합니다.
                                        setState(() {
                                          this.selectedDay = selectedDay;
                                          this.focusedDay = focusedDay;
                                        });
                                      },
                                      selectedDayPredicate: (DateTime day) {
                                        // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                                        return isSameDay(selectedDay, day);
                                      },
                                    );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                        ),
                        child: Text('$option1 | $option2'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(child: getDataTable())),
          ],
        ),
      ),
    );
  }
}
