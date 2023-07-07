import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/widgets/month_selection_button.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:core';

class InsertDeepAgingData extends StatefulWidget {
  final DeepAgingData agingdata;
  const InsertDeepAgingData({super.key, required this.agingdata});

  @override
  State<InsertDeepAgingData> createState() => _InsertDeepAgingDataState();
}

class _InsertDeepAgingDataState extends State<InsertDeepAgingData> {
  final TextEditingController textEditingController1 = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  String? selectedMonth;
  bool month = false;
  String? selectedDay;
  bool day = false;
  String? selectedYear;
  bool year = false;
  DateTime selected = DateTime(
    DateTime.utc(2022, 12, 1).year,
    DateTime.utc(2022, 12, 1).month,
    DateTime.utc(2022, 12, 1).day,
  );

  DateTime focusedDay = DateTime.utc(2022, 12, 1);

  bool isInsertedHour = false;
  bool isInsertedMinute = false;
  bool isInsertedMonth = false;
  bool isInsertedDay = false;
  bool isInsertedYear = false;

  bool isFinal = false;

  int? selectedHour;
  int? selectedMinute;

  List<String> monthData = [
    '1월',
    '2월',
    '3월',
    '4월',
    '5월',
    '6월',
    '7월',
    '8월',
    '9월',
    '10월',
    '11월',
    '12월'
  ];
  List<int> yearData =
      List<int>.generate(2023 - 2003 + 1, (int index) => 2023 - index);
  int initialValue = 0;

  RegExp num = RegExp(r'^[0-9]+$');

  @override
  void initState() {
    super.initState();
    if (widget.agingdata.insertedHour != null) {
      selectedMonth = widget.agingdata.selectedMonth;
      selectedDay = widget.agingdata.selectedDay;
      selectedYear = widget.agingdata.selectedYear;
      selectedHour = int.parse(widget.agingdata.insertedHour!);
      textEditingController1.text = widget.agingdata.insertedHour!;
      selectedMinute = int.parse(widget.agingdata.insertedMinute!);
      textEditingController2.text = widget.agingdata.insertedMinute!;
      isInsertedDay = true;
      isInsertedHour = true;
      isInsertedMinute = true;
      isInsertedMonth = true;
      isInsertedYear = true;
      successAssign();
    }
  }

  void saveData(DeepAgingData deepData) {
    deepData.selectedMonth = selectedMonth;
    deepData.selectedDay = selectedDay;
    deepData.selectedYear = selectedYear;
    deepData.insertedHour = selectedHour.toString();
    deepData.insertedMinute = selectedMinute.toString();
  }

  void setting() {
    if (int.parse(selectedMonth!) < 10 && !selectedMonth!.startsWith('0')) {
      selectedMonth = '0$selectedMonth';
    }
    if (int.parse(selectedDay!) < 10 && !selectedDay!.startsWith('0')) {
      selectedDay = '0$selectedDay';
    }
  }

  void successAssign() {
    if (isInsertedDay &&
        isInsertedHour &&
        isInsertedMinute &&
        isInsertedYear &&
        isInsertedMonth) {
      setState(() {
        isFinal = true;
      });
    } else {
      setState(() {
        isFinal = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: '딥에이징 데이터 추가',
        backButton: false,
        closeButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    month = false;
                    day = false;
                    year = false;
                    FocusScope.of(context).unfocus();
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                              bottom: 5.0,
                            ),
                            child: Text(
                              'Deep Aging 일자',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (year == false && day == false) {
                                      month = !month;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (selectedMonth == null)
                                      ? Colors.grey[400]
                                      : Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  (selectedMonth != null)
                                      ? '$selectedMonth월'
                                      : '월',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (month == false && year == false) {
                                      day = !day;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (selectedDay == null)
                                      ? Colors.grey[400]
                                      : Colors.grey[800],
                                  disabledBackgroundColor: Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  (selectedDay != null) ? '$selectedDay일' : '일',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              height: 50.0,
                              margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (month == false && day == false) {
                                      year = !year;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (selectedYear == null)
                                      ? Colors.grey[400]
                                      : Colors.grey[800],
                                  disabledBackgroundColor: Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  (selectedYear != null)
                                      ? '$selectedYear'
                                      : '년도',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (month)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: MonthSelectionButton(
                              months: monthData,
                              onMonthSelected: (selected) {
                                setState(() {
                                  selectedMonth = selected;
                                  month = false;
                                  isInsertedMonth = true;
                                  successAssign();
                                });
                              },
                            ),
                          ),
                        ),
                      if (year)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: CupertinoPicker.builder(
                                scrollController: FixedExtentScrollController(
                                  initialItem: yearData.indexOf(initialValue),
                                ),
                                itemExtent: 86,
                                childCount: yearData.length,
                                backgroundColor: Colors.white,
                                onSelectedItemChanged: (i) {
                                  setState(() {
                                    selectedYear = yearData[i].toString();
                                    initialValue = yearData[i];
                                    isInsertedYear = true;
                                    successAssign();
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Text(yearData[index].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 35.0,
                                        )),
                                  );
                                }),
                          ),
                        ),
                      if (day)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: TableCalendar(
                              locale: 'ko_KR',
                              firstDay: DateTime.utc(2022, 12, 1),
                              lastDay: DateTime.utc(2022, 12, 31),
                              focusedDay: focusedDay,
                              rowHeight: 35.0,
                              headerVisible: false,
                              daysOfWeekVisible: false,
                              onDaySelected:
                                  (DateTime selected, DateTime focusedDay) {
                                setState(() {
                                  this.selected = selected;
                                  this.focusedDay = focusedDay;
                                  selectedDay = selected.day.toString();
                                  day = false;
                                  isInsertedDay = true;
                                  successAssign();
                                });
                              },
                              selectedDayPredicate: (DateTime day) {
                                return isSameDay(selected, day);
                              },
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: false,
                                selectedDecoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                selectedTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                weekendTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                defaultTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                todayTextStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                outsideDaysVisible: false,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: (!year && !day && !month) ? 215.0 : 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '초음파 처리 시간',
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (num.hasMatch(value)) {
                                    selectedHour = int.parse(value);
                                    isInsertedHour = true;
                                    successAssign();
                                  }
                                });
                              },
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: textEditingController1,
                              showCursor: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(right: 5.0, top: 10.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2.5),
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 8.0,
                              ),
                              child: Text(
                                '시간',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (num.hasMatch(value)) {
                                    selectedMinute = int.parse(value);
                                    isInsertedMinute = true;
                                    successAssign();
                                  }
                                });
                              },
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: textEditingController2,
                              showCursor: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(right: 5.0, top: 10.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2.5),
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 8.0,
                              ),
                              child: Text(
                                '분',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: 20.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SaveButton(
              isWhite: false,
              text: '저장',
              width: 658.w,
              heigh: 104.h,
              onPressed: isFinal
                  ? () {
                      setting();
                      saveData(widget.agingdata);
                      Navigator.pop(context, widget.agingdata);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
