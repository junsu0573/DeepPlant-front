import 'package:deep_plant_app/models/data_management_filter_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/data_table_confirm_widget.dart';
import 'package:deep_plant_app/widgets/data_table_guide.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/data_page_toggle_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DataConfirm extends StatefulWidget {
  final UserData userData;
  final FilterModel filter;
  final MeatData meatData;
  DataConfirm({
    super.key,
    required this.userData,
    required this.filter,
    required this.meatData,
  });

  @override
  State<DataConfirm> createState() => DataConfirmState();
}

class DataConfirmState extends State<DataConfirm> {
  final TextEditingController search = TextEditingController();
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  FocusNode focusNode = FocusNode();
  String text = '';
  String temp1 = '';
  String temp2 = '';
  List<bool>? selections1;
  List<bool>? tempSelections1;
  List<bool>? selections2;
  List<bool>? tempSelections2;
  List<bool>? selections3;
  List<bool>? tempSelections3;

  String? option1;
  String? tempOption1;
  String? option2;
  String? tempOption2;
  String? option3;
  String? tempOption3;
  List<Widget>? options1;
  List<Widget> options2 = [
    Text('나의 데이터'),
    Text('일반 데이터'),
    Text('연구 데이터'),
    Text('전체'),
  ];
  List<Widget> options3 = [
    Text('소'),
    Text('돼지'),
    Text('전체'),
  ];

  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  String? start;
  String? end;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    if (widget.filter.confirmOption1 == null) {
      widget.filter.resetCon();
    }
    setting();
    setTime();
  }

  void setting() {
    selections1 = widget.filter.confirmSelections1!;
    selections2 = widget.filter.confirmSelections2!;
    selections3 = widget.filter.confirmSelections3!;
    option1 = widget.filter.confirmOption1!;
    tempOption1 = option1;
    option2 = widget.filter.confirmOption2!;
    tempOption2 = option2;
    option3 = widget.filter.confirmOption3!;
    tempOption3 = option3;
    options1 = widget.filter.confirmOptions1!;
    _rangeStart = widget.filter.rangeStart;
    tempRangeStart = _rangeStart;
    _rangeEnd = widget.filter.rangeEnd;
    tempRangeEnd = _rangeEnd;
    temp1 = widget.filter.temp1!;
    temp2 = widget.filter.temp2!;
    selectedEtc = widget.filter.flag!;
  }

  void editing() {
    widget.filter.confirmSelections1 = selections1;
    widget.filter.confirmSelections2 = selections2;
    widget.filter.confirmSelections3 = selections3;
    widget.filter.confirmOption1 = option1;
    widget.filter.confirmOption2 = option2;
    widget.filter.confirmOption3 = option3;
    widget.filter.confirmOptions1 = options1;
    widget.filter.rangeStart = _rangeStart;
    widget.filter.rangeEnd = _rangeEnd;
    widget.filter.temp1 = temp1;
    widget.filter.temp2 = temp2;
    widget.filter.flag = selectedEtc;
  }

  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo = toDay!.subtract(Duration(days: 3));
    monthsAgo = toDay!.subtract(Duration(days: 30));
    threeMonthsAgo = toDay!.subtract(Duration(days: 30 * 3));

    if (option1 == '3일') {
      start = DateFormat('yyyy-MM-ddTHH:mm:ss').format(threeDaysAgo!);
      end = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else if (option1 == '1개월') {
      start = DateFormat('yyyy-MM-ddTHH:mm:ss').format(monthsAgo!);
      end = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else if (option1 == '3개월') {
      start = DateFormat('yyyy-MM-ddTHH:mm:ss').format(threeMonthsAgo!);
      end = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else {
      start = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_rangeStart!);
      end = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_rangeEnd!);
    }
  }

  Future<List<String>> initialize(int count, String start, String end) async {
    List<String> temp;
    final data = await ApiServices.getCreatedAtData(count, start, end);
    print(start);
    print(end);
    temp = extractedData(data['meat_dict']);
    return temp;
  }

  List<String> extractedData(dynamic data) {
    List<String> extracted = [];

    data.forEach((key, item) {
      String createdAt = item['createdAt'];
      createdAt = createdAt.replaceFirst('T', ' ');
      String name = item['name'];
      String id = item['id'];
      String specieValue = item['specieValue'];
      String statusType = item['statusType'];
      String type = item['type'];
      String userId = item['userId'];
      extracted.add('$createdAt,$name,$id,$specieValue,$statusType,$type,$userId');
    });
    return extracted;
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? tempRangeStart;
  DateTime? tempRangeEnd;

  bool selectedEtc = false;
  bool selectedFinal = true;

  manageDataState() {
    search.addListener(() {
      setState(() {
        text = search.text;
      });
    });
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
              '육류 데이터 확인',
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
                            tempSelections1 = List<bool>.from(selections1!);
                            tempSelections2 = List<bool>.from(selections2!);
                            tempSelections3 = List<bool>.from(selections3!);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
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
                                                bottomState1(() {
                                                  selectedEtc = true;
                                                  if (index == 3) {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isDismissible: false,
                                                        isScrollControlled: true,
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
                                                                                                        tempRangeStart = selectDate;
                                                                                                        temp1 = DateFormat('MM/dd').format(tempRangeStart!);
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
                                                                                                        tempRangeEnd = selectDate;
                                                                                                        temp2 = DateFormat('MM/dd').format(tempRangeEnd!);
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
                                                                          bottomState1(() {
                                                                            if (tempRangeEnd != null && tempRangeStart != null) {
                                                                              tempOption1 = '$temp1-$temp2';
                                                                              options1![3] = Text(tempOption1!);
                                                                              selectedFinal = true;
                                                                            } else {
                                                                              tempOption1 = '직접설정';
                                                                              options1![3] = Text(tempOption1!);
                                                                              selectedFinal = false;
                                                                            }
                                                                          });
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
                                                                    onRangeSelected: (startDay, endDay, focusedDay) {
                                                                      bottomState2(
                                                                        () {
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
                                                  for (int i = 0; i < tempSelections1!.length; i++) {
                                                    if (i == index) {
                                                      tempSelections1![i] = true;
                                                      tempOption1 = (options1![i] as Text).data.toString();
                                                      if (index != 3) {
                                                        selectedFinal = true;
                                                      }
                                                    } else {
                                                      tempSelections1![i] = false;
                                                    }
                                                  }
                                                });
                                              },
                                              options: options1!,
                                              isSelected: tempSelections1!,
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
                                                bottomState1(() {
                                                  for (int i = 0; i < tempSelections2!.length; i++) {
                                                    if (i == index) {
                                                      tempSelections2![i] = true;
                                                      tempOption2 = (options2[i] as Text).data.toString();
                                                    } else {
                                                      tempSelections2![i] = false;
                                                    }
                                                  }
                                                });
                                              },
                                              options: options2,
                                              isSelected: tempSelections2!,
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
                                                bottomState1(() {
                                                  for (int i = 0; i < tempSelections3!.length; i++) {
                                                    if (i == index) {
                                                      tempSelections3![i] = true;
                                                      tempOption3 = (options3[i] as Text).data.toString();
                                                    } else {
                                                      tempSelections3![i] = false;
                                                    }
                                                  }
                                                });
                                              },
                                              options: options3,
                                              isSelected: tempSelections3!,
                                              isRadius: false,
                                              minHeight: 30.0,
                                              minWidth: 105.0,
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
                                                          selections1 = List.from(tempSelections1!);
                                                          selections2 = List.from(tempSelections2!);
                                                          selections3 = List.from(tempSelections3!);
                                                          option1 = tempOption1;
                                                          option2 = tempOption2;
                                                          option3 = tempOption3;
                                                          _rangeStart = tempRangeStart;
                                                          _rangeEnd = tempRangeEnd;
                                                          if (option1 == '3일' || option1 == '1개월' || option1 == '3개월') {
                                                            selectedEtc = false;
                                                            tempRangeEnd = null;
                                                            tempRangeStart = null;
                                                            temp1 = '';
                                                            temp2 = '';
                                                            options1![3] = Text('직접설정');
                                                          }
                                                          editing();
                                                          setTime();
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
            DataTableGuide(),
            Expanded(
              child: FutureBuilder<List<String>>(
                  future: initialize(20, start!, end!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}\n에러가 발생했습니다!');
                    } else {
                      return GetConfirmTable(
                        userData: snapshot.data!,
                        text: text,
                        data: manageDataState,
                        option2: option2!,
                        option3: option3!,
                        selectedEtc: selectedEtc,
                        user: widget.userData,
                        meat: widget.meatData,
                        start: _rangeStart,
                        end: _rangeEnd,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
