import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
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
  final MeatData meatData;
  const InsertDeepAgingData({
    super.key,
    required this.agingdata,
    required this.meatData,
  });

  @override
  State<InsertDeepAgingData> createState() => _InsertDeepAgingDataState();
}

class _InsertDeepAgingDataState extends State<InsertDeepAgingData> {
  // 두 개의 textfield를 제어하기 위해 사용
  final TextEditingController textEditingController2 = TextEditingController();

  // 시간 변수의 초기 값 -> 변경 금지!
  DateTime selected = DateTime(
    DateTime.utc(2022, 12, 1).year,
    DateTime.utc(2022, 12, 1).month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.utc(2022, 12, 1);

  // 년, 월, 일 필드의 on/off 상태를 제어함.
  bool month = false;
  bool day = false;
  bool year = false;

  // 대상 값들이 들어오게 될 변수
  String selectedMonth = DateTime.now().month.toString();
  String selectedDay = DateTime.now().day.toString();
  String selectedYear = DateTime.now().year.toString();
  String? selectedMinute;

  // 대상 값들이 입력되었는지 확인
  bool isInsertedMinute = false;
  bool isInsertedMonth = true;
  bool isInsertedDay = true;
  bool isInsertedYear = true;

  // 최종 상태를 결정짓는 변수
  bool isFinal = false;

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
  // 2023 ~ 2003 까지의 연도 필드
  List<int> yearData =
      List<int>.generate(2023 - 2003 + 1, (int index) => 2023 - index);
  // 연도의 현재 위치를 결정 지음
  int yearFieldValue = 0;

  // text field에서 숫자만 인식 되도록 지정 -> 문자가 입력될 경우 예외가 발생하기 때문.
  RegExp num = RegExp(r'^[0-9]+$');

  @override
  void initState() {
    super.initState();
    if (widget.agingdata.insertedMinute != null) {
      initialize();
    }
  }

  void initialize() {
// 여기에 0붙으면 때어버리게 추가
    selectedMonth = widget.agingdata.selectedMonth!;
    selectedDay = widget.agingdata.selectedDay!;
    selectedYear = widget.agingdata.selectedYear!;
    selectedMinute = widget.agingdata.insertedMinute;
    textEditingController2.text = widget.agingdata.insertedMinute!;
    isInsertedDay = true;
    isInsertedMinute = true;
    isInsertedMonth = true;
    isInsertedYear = true;
    isFinal = true;
  }

  void saveData(DeepAgingData deepData) {
    // 객체에 최종적인 값을 전달하게 된다.
    deepData.selectedMonth = selectedMonth;
    deepData.selectedDay = selectedDay;
    deepData.selectedYear = selectedYear;
    deepData.insertedMinute = selectedMinute;
    String data = '$selectedYear$selectedMonth$selectedDay/$selectedMinute';
    if (widget.meatData.deepAging != null) {
      widget.meatData.deepAging!.add(data);
    } else {
      widget.meatData.deepAging = [data];
    }
  }

  void setting() {
    // 최종적으로 '월, 일'에 들어갈 때 10 이하의 경우 앞에 0을 추가해준다.
    if (int.parse(selectedMonth) < 10 && !selectedMonth.startsWith('0')) {
      selectedMonth = '0$selectedMonth';
    }
    // else {
    //   selectedMonth = selectedMonth.substring(1, selectedMonth.length);
    // }
    if (int.parse(selectedDay) < 10 && !selectedDay.startsWith('0')) {
      selectedDay = '0$selectedDay';
    }
    //  else {
    //   selectedDay = selectedDay.substring(1, selectedDay.length);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '딥에이징 데이터 추가',
        backButton: false,
        closeButton: true,
      ),
      body: GestureDetector(
        // 외부를 클릭할 경우, textfield의 해제와 datafield의 해제가 일어난다.
        onTap: () {
          setState(() {
            month = false;
            day = false;
            year = false;
            FocusScope.of(context).unfocus();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
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
                                    if (month == true) {
                                      month = false;
                                    } else {
                                      year = false;
                                      day = false;
                                      month = true;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  '$selectedMonth월',
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
                                    if (day == true) {
                                      day = false;
                                    } else {
                                      year = false;
                                      month = false;
                                      day = true;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  disabledBackgroundColor: Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  '$selectedDay일',
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
                                    if (year == true) {
                                      year = false;
                                    } else {
                                      month = false;
                                      day = false;
                                      year = true;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  disabledBackgroundColor: Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  selectedYear,
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
                                  initialItem: yearData.indexOf(yearFieldValue),
                                ),
                                itemExtent: 86,
                                childCount: yearData.length,
                                backgroundColor: Colors.white,
                                onSelectedItemChanged: (i) {
                                  setState(() {
                                    selectedYear = yearData[i].toString();
                                    yearFieldValue = yearData[i];
                                    isInsertedYear = true;
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
                                  if (num.hasMatch(value) &&
                                      int.parse(value) != 0) {
                                    selectedMinute = value;
                                    isInsertedMinute = true;
                                    isFinal = true;
                                  } else {
                                    isFinal = false;
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
              SizedBox(
                height: 20.0,
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
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
