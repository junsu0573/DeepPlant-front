import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_table_calendat.dart';

import 'package:structure/components/main_button.dart';
import 'package:structure/components/nonform_text_field.dart';
import 'package:structure/viewModel/data_management/add_deep_aging_data_view_model.dart';

class AddDeepAgingDataScreen extends StatefulWidget {
  const AddDeepAgingDataScreen({super.key});

  @override
  State<AddDeepAgingDataScreen> createState() => _AddDeepAgingDataScreenState();
}

class _AddDeepAgingDataScreenState extends State<AddDeepAgingDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
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
                      const Row(
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
                      Consumer<AddDeepAgingDataViewModel>(
                        builder: (context, viewModel, child) => Container(
                          padding: const EdgeInsets.all(3.0),
                          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          width: 350.w,
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (context
                          .watch<AddDeepAgingDataViewModel>()
                          .isSelectedDate)
                        CustomTableCalendar(
                            focusedDay: context
                                .watch<AddDeepAgingDataViewModel>()
                                .focused,
                            selectedDay: context
                                .watch<AddDeepAgingDataViewModel>()
                                .selected,
                            onDaySelected: (selectedDay, focusedDay) => context
                                .read<AddDeepAgingDataViewModel>()
                                .onDaySelected(selectedDay, focusedDay)),
                      SizedBox(
                        height: (context
                                .read<AddDeepAgingDataViewModel>()
                                .isSelectedDate)
                            ? 215.0
                            : 20,
                      ),
                      const Row(
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
                                textStyle: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textEditingController: context
                                    .read<AddDeepAgingDataViewModel>()
                                    .textEditingController,
                                textInputType: TextInputType.number,
                                onChanged: (value) => context
                                    .read<AddDeepAgingDataViewModel>()
                                    .changeState(value),
                              )),
                          const Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(
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
                          const Expanded(
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
              const SizedBox(
                height: 20.0,
              ),
              MainButton(
                isWhite: false,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                onPressed:
                    context.watch<AddDeepAgingDataViewModel>().isInsertedMinute
                        ? () async => context
                            .read<AddDeepAgingDataViewModel>()
                            .saveData(context)
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
