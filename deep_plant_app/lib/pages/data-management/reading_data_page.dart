import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/data_page_toggle_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:deep_plant_app/widgets/data_table_source.dart';

class ReadingData extends StatefulWidget {
  ReadingData({super.key, required this.user});
  final UserModel user;

  @override
  State<ReadingData> createState() => ReadingDataState();
}

class ReadingDataState extends State<ReadingData> {
  final TextEditingController search = TextEditingController();
  FocusNode focusNode = FocusNode();

  // 필터에 이용되는 변수들
  final List<bool> _selections1 = [false, true, false, false];
  final List<bool> _selections2 = [true, false];
  String option1 = '1개월';
  String option2 = '최신순';

  bool isSelectedTable = false;
  String text = '';

  // 아래의 두 변수는 중간 계산을 위함이니 수정 금지!!
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  // 이건 단순히 오늘 날짜를 얻어오는 변수
  DateTime toDay = DateTime.now();

  // 여기서 table을 만들 값이 들어오게 된다.
  final List<String> userData = [
    '000189843795,test, ',
    '000189843895,test, ',
    '000189843995-cattle-tenderloin-ribeye_roll,전수현, ',
    '000189843595-cattle-sirloin-boneless_short_rib,전수현, ',
    '000189843495-cattle-blade-tirmmed_rib,전수현, ',
    '000189843695,test, ',
  ];

  // 이는 검색 기능을 관리한다.
  manageDataState() {
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
    // fetchJsonData();
  }

  Future<void> fetchJsonData() async {
    var apiUrl = 'http://10.221.71.228:8080/user?id=junsu030401@gmail.com';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // var jsonData = jsonDecode(response.body)['meatList'] as List<String>;
        // var ids = extractIds(jsonData);
        // for (int i = 0; i < ids.length; i++) {
        //   userData.add('${ids[i]},${widget.user.name}, ');
        // }
      } else {
        // Error handling
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Exception handling
      print('Error: $e');
    }
  }

  // 아래의 두 함수는 현재 표시되는 필터 text를 결정짓는다.
  void insertOption1(String option) {
    option1 = option;
  }

  void insertOption2(String option) {
    option2 = option;
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
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 15.0,
                bottom: 15.0,
              ),
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
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.2, color: Colors.grey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.2, color: Colors.grey),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              ),
                            ),
                            builder: (BuildContext context) {
                              return TableCalendar(
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
                                  setState(
                                    () {
                                      this.selectedDay = selectedDay;
                                      this.focusedDay = focusedDay;
                                      context.pop();
                                    },
                                  );
                                },
                                selectedDayPredicate: (DateTime day) {
                                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                                  return isSameDay(selectedDay, day);
                                },
                              );
                              // return Container(
                              //   margin: EdgeInsets.all(18.0),
                              //   height: 300,
                              //   child: Center(
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: <Widget>[
                              //         Text(
                              //           '조회기간',
                              //           style: TextStyle(
                              //             fontSize: 18.0,
                              //           ),
                              //         ),
                              //         ToggleButton(
                              //           insertOptionFunc: insertOption1,
                              //           options: [
                              //             Text('3일'),
                              //             Text('1개월'),
                              //             Text('3개월'),
                              //             Text('직접설정'),
                              //           ],
                              //           isSelected: _selections1,
                              //           isRadius: false,
                              //           minHeight: 30.0,
                              //           minWidth: 80.0,
                              //         ),
                              //         Text(
                              //           '정렬',
                              //           style: TextStyle(
                              //             fontSize: 18.0,
                              //           ),
                              //         ),
                              //         ToggleButton(
                              //           insertOptionFunc: insertOption2,
                              //           options: [
                              //             Text('최신순'),
                              //             Text('과거순'),
                              //           ],
                              //           isSelected: _selections2,
                              //           isRadius: false,
                              //           minHeight: 30.0,
                              //           minWidth: 160.0,
                              //         ),
                              //         SaveButton(
                              //           text: '확인',
                              //           width: 658.w,
                              //           heigh: 104.h,
                              //           isWhite: false,
                              //           onPressed: () {
                              //             Navigator.pop(context);
                              //             setState(
                              //               () {
                              //                 if (option2 == '최신순') {
                              //                   sortDscending = true;
                              //                   sortAscending = false;
                              //                 } else if (option2 == '과거순') {
                              //                   sortDscending = false;
                              //                   sortAscending = true;
                              //                 }
                              //               },
                              //             );
                              //           },
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // );
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
            Expanded(child: SingleChildScrollView(child: getDataTable(userData, text, manageDataState))),
          ],
        ),
      ),
    );
  }

  TableCalendar<dynamic> newMethod() {
    return TableCalendar(
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
        setState(
          () {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          },
        );
      },
      selectedDayPredicate: (DateTime day) {
        // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
        return isSameDay(selectedDay, day);
      },
    );
  }
}
