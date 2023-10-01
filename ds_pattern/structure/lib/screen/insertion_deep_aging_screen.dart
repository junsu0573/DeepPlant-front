import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/viewModel/insertion_deep_aging_view_model.dart';

class InsertionDeepAgingScreen extends StatefulWidget {
  const InsertionDeepAgingScreen({super.key});

  @override
  State<InsertionDeepAgingScreen> createState() => _InsertionDeepAgingScreenState();
}

class _InsertionDeepAgingScreenState extends State<InsertionDeepAgingScreen> {
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
        onTap: () {
          setState(() {
            context.read<InsertionDeepAgingViewModel>().reset();
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
                      Consumer<InsertionDeepAgingViewModel>(
                        builder: (context, viewModel, child) => Row(
                          children: [
                            TempWidget(
                              tempText: "${viewModel.selectedMonth}월",
                              tempState: (value) => viewModel.changeState("Month"),
                            ),
                            TempWidget(
                              tempText: "${viewModel.selectedDay}일",
                              tempState: (value) => viewModel.changeState("Day"),
                            ),
                            TempWidget(
                              tempText: viewModel.selectedYear,
                              tempState: (value) => viewModel.changeState("Year"),
                            ),
                          ],
                        ),
                      ),
                      // if (month)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       height: 180.0,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15),
                      //         color: Colors.white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             spreadRadius: 5,
                      //             blurRadius: 7,
                      //             offset: Offset(0, 3),
                      //           )
                      //         ],
                      //       ),
                      //       child: MonthSelectionButton(
                      //         months: monthData,
                      //         onMonthSelected: (selected) {
                      //           setState(() {
                      //             selectedMonth = selected;
                      //             month = false;
                      //             isInsertedMonth = true;
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // if (year)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 180,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15),
                      //         color: Colors.white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             spreadRadius: 5,
                      //             blurRadius: 7,
                      //             offset: Offset(0, 3),
                      //           )
                      //         ],
                      //       ),
                      //       child: CupertinoPicker.builder(
                      //           scrollController: FixedExtentScrollController(
                      //             initialItem: yearData.indexOf(yearFieldValue),
                      //           ),
                      //           itemExtent: 86,
                      //           childCount: yearData.length,
                      //           backgroundColor: Colors.white,
                      //           onSelectedItemChanged: (i) {
                      //             setState(() {
                      //               selectedYear = yearData[i].toString();
                      //               yearFieldValue = yearData[i];
                      //               isInsertedYear = true;
                      //             });
                      //           },
                      //           itemBuilder: (context, index) {
                      //             return Center(
                      //               child: Text(yearData[index].toString(),
                      //                   style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 35.0,
                      //                   )),
                      //             );
                      //           }),
                      //     ),
                      //   ),
                      // if (day)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       height: 180.0,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(15),
                      //         color: Colors.white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             spreadRadius: 5,
                      //             blurRadius: 7,
                      //             offset: Offset(0, 3),
                      //           )
                      //         ],
                      //       ),
                      //       child: TableCalendar(
                      //         locale: 'ko_KR',
                      //         firstDay: DateTime.utc(2022, 12, 1),
                      //         lastDay: DateTime.utc(2022, 12, 31),
                      //         focusedDay: focusedDay,
                      //         rowHeight: 35.0,
                      //         headerVisible: false,
                      //         daysOfWeekVisible: false,
                      //         onDaySelected: (DateTime selected, DateTime focusedDay) {
                      //           setState(() {
                      //             this.selected = selected;
                      //             this.focusedDay = focusedDay;
                      //             selectedDay = selected.day.toString();
                      //             day = false;
                      //             isInsertedDay = true;
                      //           });
                      //         },
                      //         selectedDayPredicate: (DateTime day) {
                      //           return isSameDay(selected, day);
                      //         },
                      //         calendarStyle: CalendarStyle(
                      //           isTodayHighlighted: false,
                      //           selectedDecoration: const BoxDecoration(
                      //             color: Colors.white,
                      //             shape: BoxShape.circle,
                      //           ),
                      //           selectedTextStyle: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 20.0,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //           weekendTextStyle: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16.0,
                      //           ),
                      //           defaultTextStyle: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16.0,
                      //           ),
                      //           todayTextStyle: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16.0,
                      //           ),
                      //           outsideDaysVisible: false,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      SizedBox(
                        height: (context.read<InsertionDeepAgingViewModel>().isAllnotSelected) ? 215.0 : 20,
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
                                if (int.parse(value) != 0) {
                                  context.read<InsertionDeepAgingViewModel>().changeState(value);
                                }
                              },
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: context.read<InsertionDeepAgingViewModel>().textEditingController,
                              showCursor: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(right: 5.0, top: 10.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.5),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.5),
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
              MainButton(
                isWhite: false,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                onPressed: context.read<InsertionDeepAgingViewModel>().isInsertedMinute
                    ? () {
                        context.read<InsertionDeepAgingViewModel>().saveData();
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

class TempWidget extends StatelessWidget {
  const TempWidget({
    super.key,
    required this.tempState,
    required this.tempText,
  });

  final Function(String state) tempState;
  final String tempText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(3.0),
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        height: 50.0,
        child: ElevatedButton(
          onPressed: () {
            tempState;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            tempText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
