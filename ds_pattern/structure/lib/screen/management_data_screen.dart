import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_management_table.dart';
import 'package:structure/components/custom_table_calendar.dart';
import 'package:structure/components/custom_temp_widget.dart';
import 'package:structure/components/custom_toggle_button.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/nonform_text_field.dart';
import 'package:structure/viewModel/management_data_view_model.dart';

class ManagementDataScreen extends StatefulWidget {
  const ManagementDataScreen({super.key});

  @override
  State<ManagementDataScreen> createState() => _ManagementDataScreenState();
}

class _ManagementDataScreenState extends State<ManagementDataScreen> {
  List<bool> tempSelections1 = [true, false, false, false];
  List<bool> tempSelections2 = [true, false, false, false];
  List<bool> tempSelections3 = [false, false, true];

  String tempOption1 = '3일';
  String tempOption2 = '나의 데이터';
  String tempOption3 = '전체';

  DateTime? tempRangeStart;
  DateTime? tempRangeEnd;
  String temp1 = '';
  String temp2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Text(
              '삭제 예정!',
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
                      child: Consumer<ManagementDataViewModel>(
                        builder: (context, viewModel, child) => NonformTextField(
                          focusNode: viewModel.focusNode,
                          textStyle: TextStyle(fontSize: 13.5),
                          textEditingController: viewModel.controller,
                          textInputType: TextInputType.text,
                          hintText: '관리번호 입력',
                          labelColor: Colors.white,
                          suffixIcon: viewModel.focusNode.hasFocus
                              ? IconButton(
                                  onPressed: viewModel.textClear,
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey[400],
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                    Consumer<ManagementDataViewModel>(
                      builder: (context, viewModel, child) => Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              tempSelections1 = List<bool>.from(viewModel.selectionsDay!);
                              tempSelections2 = List<bool>.from(viewModel.selectionsData!);
                              tempSelections3 = List<bool>.from(viewModel.selectionsSpecies!);
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
                                              CustomToggleButton(
                                                onPressed: (index) {
                                                  bottomState1(() {
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
                                                                                                  initialDateTime: (tempRangeStart == null)
                                                                                                      ? DateTime.now()
                                                                                                      : tempRangeStart,
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
                                                                                viewModel.widgetsDay[3] = Text(tempOption1);
                                                                                viewModel.isSelectedEnd = true;
                                                                              } else {
                                                                                tempOption1 = '직접설정';
                                                                                viewModel.widgetsDay[3] = Text(tempOption1);
                                                                                viewModel.isSelectedEnd = false;
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
                                                                    CustomTableCalendar(
                                                                      focusedDay: viewModel.focused,
                                                                      onDaySelected: (selectedDay, focusedDay) {},
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                          });
                                                    }
                                                    for (int i = 0; i < tempSelections1.length; i++) {
                                                      if (i == index) {
                                                        tempSelections1[i] = true;
                                                        tempOption1 = (viewModel.widgetsDay[i] as Text).data.toString();
                                                        if (index != 3) {
                                                          viewModel.isSelectedEnd = true;
                                                        }
                                                      } else {
                                                        tempSelections1[i] = false;
                                                      }
                                                    }
                                                  });
                                                },
                                                options: viewModel.widgetsDay,
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
                                              CustomToggleButton(
                                                onPressed: (index) {
                                                  bottomState1(() {
                                                    for (int i = 0; i < tempSelections2.length; i++) {
                                                      if (i == index) {
                                                        tempSelections2[i] = true;
                                                        tempOption2 = (viewModel.widgetsData[i] as Text).data.toString();
                                                      } else {
                                                        tempSelections2[i] = false;
                                                      }
                                                    }
                                                  });
                                                },
                                                options: viewModel.widgetsData,
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
                                              CustomToggleButton(
                                                onPressed: (index) {
                                                  bottomState1(() {
                                                    for (int i = 0; i < tempSelections3.length; i++) {
                                                      if (i == index) {
                                                        tempSelections3[i] = true;
                                                        tempOption3 = (viewModel.widgetsSpecies[i] as Text).data.toString();
                                                      } else {
                                                        tempSelections3[i] = false;
                                                      }
                                                    }
                                                  });
                                                },
                                                options: viewModel.widgetsSpecies,
                                                isSelected: tempSelections3,
                                                isRadius: false,
                                                minHeight: 30.0,
                                                minWidth: 105.0,
                                              ),
                                              MainButton(
                                                  text: '확인',
                                                  width: 658.w,
                                                  heigh: 104.h,
                                                  isWhite: false,
                                                  onPressed: viewModel.isSelectedEnd
                                                      ? () {
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            viewModel.selectionsDay = List.from(tempSelections1);
                                                            viewModel.selectionsData = List.from(tempSelections2);
                                                            viewModel.selectionsSpecies = List.from(tempSelections3);
                                                            viewModel.textDay = tempOption1;
                                                            viewModel.textData = tempOption2;
                                                            viewModel.textSpecies = tempOption3;
                                                            viewModel.rangeStart = tempRangeStart;
                                                            viewModel.rangeEnd = tempRangeEnd;
                                                            if (viewModel.textDay == '3일' || viewModel.textDay == '1개월' || viewModel.textDay == '3개월') {
                                                              tempRangeEnd = null;
                                                              tempRangeStart = null;
                                                              temp1 = '';
                                                              temp2 = '';
                                                              viewModel.widgetsDay[3] = Text('직접설정');
                                                            }
                                                            viewModel.setTime();
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
                    ),
                  ],
                ),
              ),
            ),
            DataTableGuide(),
            Consumer<ManagementDataViewModel>(
              builder: (context, viewModel, child) => Expanded(
                child: FutureBuilder<List<String>>(
                    future: viewModel.initialize(20, viewModel.startDay!, viewModel.endDay!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}\n에러가 발생했습니다!');
                      } else {
                        return CustomManagementTable(userSource: snapshot.data!);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
