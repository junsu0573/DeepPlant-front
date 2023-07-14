import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/data_table_widget.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/data_page_toggle_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class DataView extends StatefulWidget {
  DataView({super.key, required this.user});
  final UserModel user;

  @override
  State<DataView> createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  final TextEditingController search = TextEditingController();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  FocusNode focusNode = FocusNode();
  String text = '';
  List<bool> selections1 = [false, true, false, false];
  List<bool> tempSelections1 = [false, true, false, false];
  List<bool> selections2 = [true, false, false, false];
  List<bool> tempSelections2 = [true, false, false, false];
  List<bool> selections3 = [true, false];
  List<bool> tempSelections3 = [true, false];

  String option1 = '1개월';
  String tempOption1 = '1개월';
  String option2 = '나의 데이터';
  String tempOption2 = '나의 데이터';
  String option3 = '소고기';
  String tempOption3 = '소고기';
  final List<Widget> options1 = [
    Text('3일'),
    Text('1개월'),
    Text('3개월'),
    Text('직접설정'),
  ];
  final List<Widget> options2 = [
    Text('나의 데이터'),
    Text('일반 데이터'),
    Text('연구 데이터'),
    Text('전체'),
  ];
  final List<Widget> options3 = [
    Text('소고기'),
    Text('돼지고기'),
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

  bool selectedEtc = false;

  final List<String> userData = [
    '000189843795,test,2023-01-22 20:44:25,normal,pig',
    '000189843895,test,2023-05-11 14:23:32,normal,pig',
    '000189843995-cattle-tenderloin-ribeye_roll,전수현,2023-07-01 14:22:23,experiment,cattle',
    '000189843595-cattle-sirloin-boneless_short_rib,전수현,2023-07-09 15:54:25,experiment,cattle',
    '000189843495-cattle-blade-tirmmed_rib,전수현,2023-07-10 02:23:32,experiment,cattle',
    '000189843695,test,2023-07-11 01:20:20,experiment,pig',
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Text(
              '육류 데이터 열람',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
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
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            tempSelections1 = List<bool>.from(selections1);
                            tempSelections2 = List<bool>.from(selections2);
                            tempSelections3 = List<bool>.from(selections3);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter bottomState) {
                                    return Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 400,
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
                                                bottomState(() {
                                                  if (index == 3) {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(15.0),
                                                            topRight: Radius.circular(15.0),
                                                          ),
                                                        ),
                                                        builder: (BuildContext context) {
                                                          return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
                                                            return Container(
                                                              margin: EdgeInsets.all(18.0),
                                                              height: 300,
                                                              child: TableCalendar(
                                                                locale: 'ko_KR',
                                                                firstDay: DateTime.utc(2023, 1, 1),
                                                                lastDay: DateTime.utc(2023, 12, 31),
                                                                focusedDay: _focusedDay,
                                                                rangeStartDay: _rangeStart,
                                                                rangeEndDay: _rangeEnd,
                                                                rangeSelectionMode: _rangeSelectionMode,
                                                                rowHeight: 35.0,
                                                                onDaySelected: (selectedDay, focusedDay) {
                                                                  bottomState(
                                                                    () {
                                                                      if (!isSameDay(_selectedDay, selectedDay)) {
                                                                        setState(() {
                                                                          _selectedDay = selectedDay;
                                                                          _focusedDay = focusedDay;
                                                                          _rangeStart = null;
                                                                          _rangeEnd = null;
                                                                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                                                                        });
                                                                      }
                                                                    },
                                                                  );
                                                                },
                                                                onRangeSelected: (startDay, endDay, focusedDay) {
                                                                  bottomState(
                                                                    () {
                                                                      setState(() {
                                                                        _selectedDay = null;
                                                                        _focusedDay = focusedDay;
                                                                        _rangeStart = startDay;
                                                                        _rangeEnd = endDay;
                                                                        _rangeSelectionMode = RangeSelectionMode.toggledOn;
                                                                      });
                                                                    },
                                                                  );
                                                                },
                                                                onPageChanged: (focusedDay) {
                                                                  var thisMonth = DateFormat('MM').format(DateTime.now());
                                                                  var movedMonth = DateFormat('MM').format(focusedDay);
                                                                  _focusedDay = focusedDay;
                                                                  bottomState(
                                                                    () {
                                                                      setState(() {
                                                                        if (movedMonth == thisMonth) {
                                                                          _selectedDay = DateTime.now();
                                                                        } else {
                                                                          _selectedDay = focusedDay;
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
                                                                    outsideDaysVisible: false,
                                                                    cellMargin: EdgeInsets.all(0),
                                                                    rangeHighlightColor: Colors.grey.shade400,
                                                                    withinRangeDecoration: const BoxDecoration(shape: BoxShape.circle),
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
                                                            );
                                                          });
                                                        });
                                                  }
                                                  for (int i = 0; i < tempSelections1.length; i++) {
                                                    if (i == index) {
                                                      tempSelections1[i] = true;
                                                      tempOption1 = (options1[i] as Text).data.toString();
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
                                              '등록자',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            ToggleButton(
                                              onPressed: (index) {
                                                bottomState(() {
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
                                              minWidth: 80.0,
                                            ),
                                            Text(
                                              '육종',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            ToggleButton(
                                              onPressed: (index) {
                                                bottomState(() {
                                                  for (int i = 0; i < tempSelections3.length; i++) {
                                                    if (i == index) {
                                                      tempSelections3[i] = true;
                                                      tempOption3 = (options3[i] as Text).data.toString();
                                                    } else {
                                                      tempSelections3[i] = false;
                                                    }
                                                  }
                                                });
                                              },
                                              options: options3,
                                              isSelected: tempSelections3,
                                              isRadius: false,
                                              minHeight: 30.0,
                                              minWidth: 160.0,
                                            ),
                                            SaveButton(
                                              text: '확인',
                                              width: 658.w,
                                              heigh: 104.h,
                                              isWhite: false,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  selections1 = List.from(tempSelections1);
                                                  selections2 = List.from(tempSelections2);
                                                  selections3 = List.from(tempSelections3);
                                                  option1 = tempOption1;
                                                  option2 = tempOption2;
                                                  option3 = tempOption3;
                                                });
                                              },
                                            ),
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
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 0.8,
                                  ))),
                          child: Text(
                            '필터',
                            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 23.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: getDataView(userData, text, manageDataState, option1, option2, option3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
