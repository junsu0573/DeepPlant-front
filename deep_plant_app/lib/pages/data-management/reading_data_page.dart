import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/data_table_widget.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/data_page_toggle_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class ReadingData extends StatefulWidget {
  final UserData userData;
  ReadingData({
    super.key,
    required this.userData,
  });

  @override
  State<ReadingData> createState() => ReadingDataState();
}

class ReadingDataState extends State<ReadingData> {
  final TextEditingController search = TextEditingController();
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  FocusNode focusNode = FocusNode();
  String text = '';
  String temp1 = '';
  String temp2 = '';
  List<bool> selections1 = [false, true, false, false];
  List<bool> tempSelections1 = [false, true, false, false];
  List<bool> selections2 = [true, false];
  List<bool> tempSelections2 = [true, false];
  String option1 = '1개월';
  String tempOption1 = '1개월';
  String option2 = '최신순';
  String tempOption2 = '최신순';
  List<Widget> options1 = [
    Text('3일'),
    Text('1개월'),
    Text('3개월'),
    Text('직접설정'),
  ];
  List<Widget> options2 = [
    Text('최신순'),
    Text('과거순'),
  ];
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // fetchJsonData();
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? tempRangeStart;
  DateTime? tempRangeEnd;

  bool sortDscending = true;
  bool selectedEtc = false;
  bool selectedFinal = true;

  final List<String> userData = [
    '000189843795,test,2023-01-22 20:44:25',
    '000189843895,test,2023-05-11 14:23:32',
    '000189843995-cattle-tenderloin-ribeye_roll,전수현,2023-07-01 14:22:23',
    '000189843595-cattle-sirloin-boneless_short_rib,전수현,2023-07-09 15:54:25',
    '000189843495-cattle-blade-tirmmed_rib,전수현,2023-07-10 02:23:32',
    '000189843695,test,2023-07-11 01:20:20',
  ];

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
                      flex: 4,
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
                          tempSelections1 = List<bool>.from(selections1);
                          tempSelections2 = List<bool>.from(selections2);
                          showModalBottomSheet(
                            context: context,
                            isDismissible: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter bottomState1) {
                                  return Container(
                                    margin: EdgeInsets.all(10.0),
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
                                            onPressed: (index) {
                                              bottomState1(() {
                                                selectedEtc = true;
                                                if (index == 3) {
                                                  showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      isDismissible: false,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(15.0),
                                                          topRight: Radius.circular(15.0),
                                                        ),
                                                      ),
                                                      builder: (BuildContext context) {
                                                        return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState2) {
                                                          return Container(
                                                            margin: EdgeInsets.all(18.0),
                                                            height: 375,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            showModalBottomSheet(
                                                                                context: context,
                                                                                isDismissible: true,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(15.0),
                                                                                    topRight: Radius.circular(15.0),
                                                                                  ),
                                                                                ),
                                                                                builder: (BuildContext context) {
                                                                                  DateTime selectDate = DateTime.now();
                                                                                  return Container(
                                                                                    height: 200,
                                                                                    margin: EdgeInsets.all(10.0),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.close,
                                                                                                  color: Colors.black,
                                                                                                  size: 26,
                                                                                                )),
                                                                                            IconButton(
                                                                                                onPressed: () {
                                                                                                  bottomState2(
                                                                                                    () {
                                                                                                      setState(() {
                                                                                                        tempRangeStart = selectDate;
                                                                                                        temp1 = DateFormat('MM/dd').format(tempRangeStart!);
                                                                                                      });
                                                                                                    },
                                                                                                  );
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.check,
                                                                                                  color: Colors.black,
                                                                                                  size: 26,
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(
                                                                                          height: 1,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 120,
                                                                                          //Cupertino형 위젯을 스타일 할때 사용하는 위젯
                                                                                          child: CupertinoTheme(
                                                                                            data: CupertinoThemeData(
                                                                                              textTheme: CupertinoTextThemeData(
                                                                                                dateTimePickerTextStyle: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 20,
                                                                                                    fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            ),
                                                                                            //Cupertino형 날짜 선택 위젯
                                                                                            child: CupertinoDatePicker(
                                                                                              backgroundColor: Colors.white,
                                                                                              //현재 날짜
                                                                                              initialDateTime:
                                                                                                  (tempRangeStart == null) ? DateTime.now() : tempRangeStart,
                                                                                              //끝 연도
                                                                                              maximumYear: DateTime.now().year,
                                                                                              //끝날짜
                                                                                              maximumDate: DateTime.now(),
                                                                                              //첫 연도
                                                                                              minimumYear: 2023,
                                                                                              //날짜 선택 모드
                                                                                              mode: CupertinoDatePickerMode.date,
                                                                                              onDateTimeChanged: (dateTime) {
                                                                                                selectDate = dateTime;
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });
                                                                          },
                                                                          child: Text(
                                                                            temp1,
                                                                            style: TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '-',
                                                                          style: TextStyle(fontSize: 30.0),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            showModalBottomSheet(
                                                                                context: context,
                                                                                isDismissible: true,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(15.0),
                                                                                    topRight: Radius.circular(15.0),
                                                                                  ),
                                                                                ),
                                                                                builder: (BuildContext context) {
                                                                                  DateTime selectDate = DateTime.now();
                                                                                  return Container(
                                                                                    height: 200,
                                                                                    margin: EdgeInsets.all(10.0),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.close,
                                                                                                  color: Colors.black,
                                                                                                  size: 26,
                                                                                                )),
                                                                                            IconButton(
                                                                                                onPressed: () {
                                                                                                  bottomState2(
                                                                                                    () {
                                                                                                      setState(() {
                                                                                                        tempRangeEnd = selectDate;
                                                                                                        temp2 = DateFormat('MM/dd').format(tempRangeEnd!);
                                                                                                      });
                                                                                                    },
                                                                                                  );
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                icon: Icon(
                                                                                                  Icons.check,
                                                                                                  color: Colors.black,
                                                                                                  size: 26,
                                                                                                )),
                                                                                          ],
                                                                                        ),
                                                                                        Divider(
                                                                                          height: 1,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 120,
                                                                                          //Cupertino형 위젯을 스타일 할때 사용하는 위젯
                                                                                          child: CupertinoTheme(
                                                                                            data: CupertinoThemeData(
                                                                                              textTheme: CupertinoTextThemeData(
                                                                                                dateTimePickerTextStyle: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontSize: 20,
                                                                                                    fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            ),
                                                                                            //Cupertino형 날짜 선택 위젯
                                                                                            child: CupertinoDatePicker(
                                                                                              backgroundColor: Colors.white,
                                                                                              //현재 날짜
                                                                                              initialDateTime:
                                                                                                  (tempRangeEnd == null) ? DateTime.now() : tempRangeEnd,
                                                                                              //끝 연도
                                                                                              maximumYear: DateTime.now().year,
                                                                                              //끝날짜
                                                                                              maximumDate: DateTime.now(),
                                                                                              //첫 연도
                                                                                              minimumYear: 2023,
                                                                                              //날짜 선택 모드
                                                                                              mode: CupertinoDatePickerMode.date,
                                                                                              onDateTimeChanged: (dateTime) {
                                                                                                selectDate = dateTime;
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });
                                                                          },
                                                                          child: Text(
                                                                            temp2,
                                                                            style: TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    InkWell(
                                                                      onTap: () {
                                                                        bottomState1(
                                                                          () {
                                                                            setState(
                                                                              () {
                                                                                if (tempRangeEnd != null && tempRangeStart != null) {
                                                                                  tempOption1 = '$temp1-$temp2';
                                                                                  options1[3] = Text(tempOption1);
                                                                                  selectedFinal = true;
                                                                                } else {
                                                                                  tempOption1 = '직접설정';
                                                                                  options1[3] = Text(tempOption1);
                                                                                  selectedFinal = false;
                                                                                }
                                                                              },
                                                                            );
                                                                          },
                                                                        );
                                                                        context.pop();
                                                                      },
                                                                      child: SizedBox(
                                                                        width: 48.w,
                                                                        height: 48.h,
                                                                        child: Image(
                                                                          image: AssetImage('assets/images/close.png'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                TableCalendar(
                                                                  locale: 'ko_KR',
                                                                  firstDay: DateTime.utc(2023, 1, 1),
                                                                  lastDay: DateTime.utc(2023, 12, 31),
                                                                  focusedDay: _focusedDay,
                                                                  rangeStartDay: tempRangeStart,
                                                                  rangeEndDay: tempRangeEnd,
                                                                  rangeSelectionMode: _rangeSelectionMode,
                                                                  rowHeight: 40.0,
                                                                  // onDaySelected: (selectedDay, focusedDay) {
                                                                  //   bottomState2(
                                                                  //     () {
                                                                  //       if (!isSameDay(_selectedDay, selectedDay)) {
                                                                  //         setState(() {
                                                                  //           _selectedDay = selectedDay;
                                                                  //           _focusedDay = focusedDay;
                                                                  //           _rangeStart = null;
                                                                  //           _rangeEnd = null;
                                                                  //           _rangeSelectionMode = RangeSelectionMode.toggledOff;
                                                                  //         });
                                                                  //       }
                                                                  //     },
                                                                  //   );
                                                                  // },
                                                                  onRangeSelected: (startDay, endDay, focusedDay) {
                                                                    bottomState2(
                                                                      () {
                                                                        setState(() {
                                                                          _selectedDay = null;
                                                                          _focusedDay = focusedDay;
                                                                          tempRangeStart = startDay;
                                                                          tempRangeEnd = endDay;
                                                                          if (tempRangeEnd != null && tempRangeStart != null) {
                                                                            temp1 = DateFormat('MM/dd').format(tempRangeStart!);
                                                                            temp2 = DateFormat('MM/dd').format(tempRangeEnd!);
                                                                          } else if (tempRangeEnd == null) {
                                                                            temp1 = DateFormat('MM/dd').format(tempRangeStart!);
                                                                            temp2 = "";
                                                                          } else if (tempRangeStart == null) {
                                                                            temp2 = DateFormat('MM/dd').format(tempRangeEnd!);
                                                                            temp1 = "";
                                                                          }
                                                                        });
                                                                      },
                                                                    );
                                                                  },
                                                                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                                                  headerStyle: HeaderStyle(
                                                                    formatButtonVisible: false,
                                                                    titleCentered: true,
                                                                    titleTextStyle: TextStyle(
                                                                      fontSize: 17.0,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    leftChevronMargin: EdgeInsets.only(left: 65.0, top: 5.0),
                                                                    rightChevronMargin: EdgeInsets.only(right: 65.0, top: 5.0),
                                                                  ),
                                                                  calendarStyle: CalendarStyle(
                                                                      outsideDaysVisible: true,
                                                                      cellMargin: EdgeInsets.all(0),
                                                                      rangeHighlightColor: Colors.grey.shade400,
                                                                      withinRangeDecoration: const BoxDecoration(shape: BoxShape.circle),
                                                                      outsideTextStyle: const TextStyle(color: Colors.transparent),
                                                                      rangeStartDecoration: const BoxDecoration(
                                                                        color: Colors.grey,
                                                                        shape: BoxShape.circle,
                                                                      ),
                                                                      rangeEndDecoration: const BoxDecoration(
                                                                        color: Colors.grey,
                                                                        shape: BoxShape.circle,
                                                                      ),
                                                                      todayDecoration: const BoxDecoration(
                                                                        color: Colors.black54,
                                                                        shape: BoxShape.circle,
                                                                      ),
                                                                      selectedDecoration: const BoxDecoration(
                                                                        color: Colors.grey,
                                                                        shape: BoxShape.circle,
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                      });
                                                }
                                                for (int i = 0; i < tempSelections1.length; i++) {
                                                  if (i == index) {
                                                    tempSelections1[i] = true;
                                                    tempOption1 = (options1[i] as Text).data.toString();
                                                    if (index != 3) {
                                                      selectedFinal = true;
                                                    }
                                                  } else {
                                                    tempSelections1[i] = false;
                                                  }
                                                }
                                              });
                                            },
                                            options: options1,
                                            isSelected: tempSelections1,
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
                                            onPressed: (index) {
                                              bottomState1(() {
                                                for (int i = 0; i < tempSelections2.length; i++) {
                                                  if (i == index) {
                                                    tempSelections2[i] = true;
                                                    tempOption2 = (options2[i] as Text).data.toString();
                                                  } else {
                                                    tempSelections2[i] = false;
                                                  }
                                                }
                                              });
                                            },
                                            options: options2,
                                            isSelected: tempSelections2,
                                            isRadius: false,
                                            minHeight: 30.0,
                                            minWidth: 160.0,
                                          ),
                                          SaveButton(
                                              text: '확인',
                                              width: 658.w,
                                              heigh: 104.h,
                                              isWhite: false,
                                              onPressed: selectedFinal
                                                  ? () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        selections1 = List.from(tempSelections1);
                                                        selections2 = List.from(tempSelections2);
                                                        option1 = tempOption1;
                                                        option2 = tempOption2;
                                                        _rangeStart = tempRangeStart;
                                                        _rangeEnd = tempRangeEnd;
                                                        if (option2 == '최신순') {
                                                          sortDscending = true;
                                                        } else if (option2 == '과거순') {
                                                          sortDscending = false;
                                                        }
                                                        if (option1 == '3일' || option1 == '1개월' || option1 == '3개월') {
                                                          selectedEtc = false;
                                                          tempRangeEnd = null;
                                                          tempRangeStart = null;
                                                          temp1 = '';
                                                          temp2 = '';
                                                          options1[3] = Text('직접설정');
                                                        }
                                                      });
                                                    }
                                                  : null),
                                        ],
                                      ),
                                    ),
                                  );
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
            Expanded(
              child: SingleChildScrollView(
                child: getDataTable(userData, text, manageDataState, sortDscending, option1, _rangeStart, _rangeEnd, selectedEtc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
