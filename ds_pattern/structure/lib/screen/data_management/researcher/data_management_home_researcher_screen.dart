import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_table_bar.dart';
import 'package:structure/components/custom_table_calendat.dart';
import 'package:structure/components/list_card_researcher.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/main_text_field.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/data_management/researcher/data_management_researcher_view_model.dart';

class DataManagementHomeResearcherScreen extends StatefulWidget {
  const DataManagementHomeResearcherScreen({super.key});

  @override
  State<DataManagementHomeResearcherScreen> createState() => _DataManagementHomeResearcherScreenState();
}

class _DataManagementHomeResearcherScreenState extends State<DataManagementHomeResearcherScreen> {
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
            height: context.watch<DataManagementHomeResearcherViewModel>().isOpenTable
                ? MediaQuery.of(context).size.height + 120.h
                : MediaQuery.of(context).size.height - 120.h,
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => context.read<DataManagementHomeResearcherViewModel>().clickedFilter(),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(context.watch<DataManagementHomeResearcherViewModel>().filterdResult),
                                context.watch<DataManagementHomeResearcherViewModel>().isOpnedFilter
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
                    context.watch<DataManagementHomeResearcherViewModel>().isOpnedFilter
                        ? const ResercherFilterBox()
                        : const SizedBox(
                            height: 10.0,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainTextField(
                            validateFunc: null,
                            onSaveFunc: null,
                            controller: context.read<DataManagementHomeResearcherViewModel>().controller,
                            focusNode: context.read<DataManagementHomeResearcherViewModel>().focusNode,
                            onChangeFunc: (value) => context.read<DataManagementHomeResearcherViewModel>().onChanged(value),
                            mainText: '관리번호 입력',
                            width: 590.w,
                            height: 72.h,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: context.watch<DataManagementHomeResearcherViewModel>().focusNode.hasFocus
                                ? IconButton(
                                    onPressed: () {
                                      context.read<DataManagementHomeResearcherViewModel>().textClear(context);
                                    },
                                    icon: const Icon(Icons.cancel))
                                : null),
                        IconButton(
                          iconSize: 48.w,
                          onPressed: () async => context.read<DataManagementHomeResearcherViewModel>().clickedQr(context),
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: const CustomTableBar(
                          isNormal: false,
                        )),
                    Expanded(
                      child: SizedBox(
                        width: 640.w,
                        child: Consumer<DataManagementHomeResearcherViewModel>(
                          builder: (context, viewModel, child) => ListView.builder(
                            itemCount: viewModel.selectedList.length,
                            itemBuilder: (context, index) => ListCardResearcher(
                              onTap: () async => await viewModel.onTap(index, context),
                              idx: index + 1,
                              num: viewModel.selectedList[index]["id"]!,
                              dayTime: viewModel.selectedList[index]["dayTime"]!,
                              userId: viewModel.selectedList[index]['userId']!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
                context.watch<DataManagementHomeResearcherViewModel>().isLoading
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

class ResercherFilterBox extends StatelessWidget {
  const ResercherFilterBox({
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
                        filterList: context.watch<DataManagementHomeResearcherViewModel>().dateList,
                        onTap: (index) => context.read<DataManagementHomeResearcherViewModel>().onTapDate(index),
                        status: context.watch<DataManagementHomeResearcherViewModel>().dateStatus),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<DataManagementHomeResearcherViewModel>(
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
                          child: Text(
                            viewModel.firstDayText,
                          ),
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
                    Consumer<DataManagementHomeResearcherViewModel>(
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
                            viewModel.lastDayText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                context.watch<DataManagementHomeResearcherViewModel>().isOpenTable
                    ? SizedBox(
                        child: Consumer<DataManagementHomeResearcherViewModel>(
                          builder: (context, viewModel, child) => CustomTableCalendar(
                              focusedDay: viewModel.focused,
                              selectedDay: viewModel.focused,
                              onDaySelected: (selectedDay, focusedDay) => viewModel.onDaySelected(selectedDay, focusedDay)),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 15.w,
                ),
                const Row(
                  children: [
                    Text('작성자'),
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
                        filterList: context.watch<DataManagementHomeResearcherViewModel>().dataList,
                        onTap: (index) => context.read<DataManagementHomeResearcherViewModel>().onTapData(index),
                        status: context.watch<DataManagementHomeResearcherViewModel>().dataStatus),
                  ],
                ),
                SizedBox(
                  height: 15.w,
                ),
                const Row(
                  children: [
                    Text('육종'),
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
                        filterList: context.watch<DataManagementHomeResearcherViewModel>().speciesList,
                        onTap: (index) => context.read<DataManagementHomeResearcherViewModel>().onTapSpecies(index),
                        status: context.watch<DataManagementHomeResearcherViewModel>().speciesStatus),
                  ],
                ),
                SizedBox(
                  height: 30.w,
                ),
                MainButton(
                  text: '조회',
                  width: 640.w,
                  heigh: 70.h,
                  isWhite: false,
                  onPressed: context.read<DataManagementHomeResearcherViewModel>().checkedFilter()
                      ? () => context.read<DataManagementHomeResearcherViewModel>().onPressedFilterSave()
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

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.filterList,
    required this.onTap,
    required this.status,
  });

  final List<String> filterList;
  final Function? onTap;
  final List<bool> status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        filterList.length,
        (index) => InkWell(
          onTap: onTap != null ? () => onTap!(index) : null,
          child: Container(
            height: 48.h,
            margin: EdgeInsets.only(right: 10.w),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
                color: status[index] ? Palette.mainButtonColor : Palette.disabledButtonColor, borderRadius: BorderRadius.all(Radius.circular(50.sp))),
            child: Text(
              filterList[index],
              style: TextStyle(
                color: status[index] ? Colors.white : Palette.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
