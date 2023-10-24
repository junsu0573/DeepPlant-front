import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_table_bar.dart';
import 'package:structure/components/custom_table_calendat.dart';
import 'package:structure/components/list_card.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/main_text_field.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/config/userfuls.dart';
import 'package:structure/screen/ui_update_screen.dart';
import 'package:structure/viewModel/data_management/normal/data_management_view_model.dart';

class DataManagementHomeScreen extends StatefulWidget {
  const DataManagementHomeScreen({super.key});

  @override
  State<DataManagementHomeScreen> createState() => _DataManagementHomeScreenState();
}

class _DataManagementHomeScreenState extends State<DataManagementHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: '데이터 관리',
          backButton: true,
          closeButton: false,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height:
                context.watch<DataManagementHomeViewModel>().isOpenTable ? MediaQuery.of(context).size.height + 100 : MediaQuery.of(context).size.height - 100,
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => context.read<DataManagementHomeViewModel>().clickedFilter(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(context.watch<DataManagementHomeViewModel>().filterdResult),
                                context.watch<DataManagementHomeViewModel>().isOpnedFilter
                                    ? const Icon(Icons.arrow_drop_up_outlined)
                                    : const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                      ],
                    ),
                    context.watch<DataManagementHomeViewModel>().isOpnedFilter
                        ? const NormalFilterBox()
                        : const SizedBox(
                            height: 10.0,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainTextField(
                          validateFunc: null,
                          onSaveFunc: null,
                          controller: context.read<DataManagementHomeViewModel>().controller,
                          onChangeFunc: (value) => context.read<DataManagementHomeViewModel>().onChanged(value),
                          focusNode: context.read<DataManagementHomeViewModel>().focusNode,
                          mainText: '관리번호 입력',
                          width: 590.w,
                          height: 72.h,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: context.watch<DataManagementHomeViewModel>().focusNode.hasFocus
                              ? IconButton(
                                  onPressed: () {
                                    context.read<DataManagementHomeViewModel>().textClear(context);
                                  },
                                  icon: const Icon(Icons.cancel),
                                )
                              : null,
                        ),
                        IconButton(
                          iconSize: 48.w,
                          onPressed: () {},
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const CustomTableBar(
                          isNormal: true,
                        )),
                    Expanded(
                      child: SizedBox(
                        width: 640.w,
                        child: Consumer<DataManagementHomeViewModel>(
                          builder: (context, viewModel, child) => ListView.builder(
                            itemCount: viewModel.selectedList.length,
                            itemBuilder: (context, index) => ListCard(
                                onTap: () async => await viewModel.onTap(index, context),
                                idx: index + 1,
                                num: viewModel.selectedList[index]["id"]!,
                                dayTime: viewModel.selectedList[index]["dayTime"]!,
                                statusType: viewModel.selectedList[index]["statusType"]!,
                                dDay: 3 -
                                    Usefuls.calculateDateDifference(
                                      viewModel.selectedList[index]["createdAt"]!,
                                    )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
                context.watch<DataManagementHomeViewModel>().isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NormalFilterBox extends StatelessWidget {
  const NormalFilterBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          const Divider(),
          SizedBox(
            height: context.watch<DataManagementHomeViewModel>().isOpenTable ? 900.h : 400.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Text('조회 기간'),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    FilterRow(
                        filterList: context.watch<DataManagementHomeViewModel>().dateList,
                        onTap: (index) => context.read<DataManagementHomeViewModel>().onTapDate(index),
                        status: context.watch<DataManagementHomeViewModel>().dateStatus),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<DataManagementHomeViewModel>(
                      builder: (context, viewModel, child) => InkWell(
                        onTap: (viewModel.dateStatus[3]) ? () => viewModel.onTapTable(0) : null,
                        child: Container(
                          width: 290.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: viewModel.dateStatus[3] ? Palette.subButtonColor : Palette.disabledButtonColor,
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text((viewModel.firstDay != null) ? DateFormat('yyyy.MM.dd').format(viewModel.firstDay!) : ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    const Text('-'),
                    SizedBox(
                      width: 20.w,
                    ),
                    Consumer<DataManagementHomeViewModel>(
                      builder: (context, viewModel, child) => InkWell(
                        onTap: (viewModel.dateStatus[3]) ? () => viewModel.onTapTable(1) : null,
                        child: Container(
                          width: 290.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: viewModel.dateStatus[3] ? Palette.subButtonColor : Palette.disabledButtonColor,
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            (viewModel.lastDay != null) ? DateFormat('yyyy.MM.dd').format(viewModel.lastDay!) : '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.w,
                ),
                context.watch<DataManagementHomeViewModel>().isOpenTable
                    ? SizedBox(
                        height: 500.h,
                        child: Consumer<DataManagementHomeViewModel>(
                          builder: (context, viewModel, child) => CustomTableCalendar(
                              focusedDay: viewModel.focused,
                              selectedDay: viewModel.selected,
                              onDaySelected: (selectedDay, focusedDay) => viewModel.onDaySelected(selectedDay, focusedDay)),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 20.w,
                ),
                const Row(
                  children: [
                    Text('정렬 순서'),
                  ],
                ),
                SizedBox(
                  height: 10.w,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    FilterRow(
                        filterList: context.watch<DataManagementHomeViewModel>().sortList,
                        onTap: (index) => context.read<DataManagementHomeViewModel>().onTapSort(index),
                        status: context.watch<DataManagementHomeViewModel>().sortStatus),
                  ],
                ),
                SizedBox(
                  height: 30.w,
                ),
                MainButton(
                  text: '조회',
                  width: 640.w,
                  heigh: 72.h,
                  isWhite: false,
                  onPressed: context.read<DataManagementHomeViewModel>().checkedFilter()
                      ? () => context.read<DataManagementHomeViewModel>().onPressedFilterSave()
                      : null,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
