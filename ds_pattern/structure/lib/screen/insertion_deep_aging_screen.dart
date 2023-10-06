import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_table_calendar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/nonform_text_field.dart';
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
          FocusScope.of(context).unfocus();
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
                              '딥에이징 일자',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Consumer<InsertionDeepAgingViewModel>(
                        builder: (context, viewModel, child) => Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.changeState('선택');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                viewModel.selectedDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (context.read<InsertionDeepAgingViewModel>().isSelectedDate)
                        CustomTableCalendar(
                            focusedDay: context.watch<InsertionDeepAgingViewModel>().focused,
                            onDaySelected: (selectedDay, focusedDay) => context.read<InsertionDeepAgingViewModel>().onDaySelected(selectedDay, focusedDay)),
                      SizedBox(
                        height: (context.read<InsertionDeepAgingViewModel>().isSelectedDate) ? 215.0 : 20,
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
                              child: NonformTextField(
                                textStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                textEditingController: context.read<InsertionDeepAgingViewModel>().textEditingController,
                                textInputType: TextInputType.number,
                                onChanged: (value) => context.read<InsertionDeepAgingViewModel>().changeState(value),
                              )),
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
