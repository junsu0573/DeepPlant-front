import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/list_card_researcher.dart';
import 'package:structure/components/main_text_field.dart';
import 'package:structure/viewModel/data_management/data_management_researcher_view_model.dart';

class DataManagementHomeResearcherScreen extends StatefulWidget {
  const DataManagementHomeResearcherScreen({super.key});

  @override
  State<DataManagementHomeResearcherScreen> createState() =>
      _DataManagementHomeResearcherScreenState();
}

class _DataManagementHomeResearcherScreenState
    extends State<DataManagementHomeResearcherScreen> {
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
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainTextField(
                      validateFunc: null,
                      onSaveFunc: null,
                      onChangeFunc: (value) => context
                          .read<DataManagementHomeResearcherViewModel>()
                          .onChanged(value),
                      mainText: '관리번호 입력',
                      width: 590.w,
                      height: 72.h,
                    ),
                    IconButton(
                      iconSize: 48.w,
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner_rounded),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Expanded(
                  child: SizedBox(
                    width: 640.w,
                    child: Consumer<DataManagementHomeResearcherViewModel>(
                      builder: (context, viewModel, child) => ListView.builder(
                        itemCount: viewModel.insertedText.isEmpty
                            ? viewModel.numList.length
                            : viewModel.filteredList.length,
                        itemBuilder: (context, index) => ListCardResearcher(
                          onTap: () async =>
                              await viewModel.onTap(index, context),
                          idx: index + 1,
                          num: viewModel.insertedText.isEmpty
                              ? viewModel.numList[index]["id"]!
                              : viewModel.filteredList[index]["id"]!,
                          createdAt: viewModel.insertedText.isEmpty
                              ? viewModel.numList[index]["createdAt"]!
                              : viewModel.filteredList[index]["createdAt"]!,
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
    );
  }
}
