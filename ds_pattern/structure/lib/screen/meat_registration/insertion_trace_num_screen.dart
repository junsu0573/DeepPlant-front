import 'package:provider/provider.dart';
import 'package:structure/components/inner_box.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/viewModel/meat_registration/insertion_trace_num_view_model.dart';

class InsertionTraceNumScreen extends StatefulWidget {
  const InsertionTraceNumScreen({super.key});

  @override
  State<InsertionTraceNumScreen> createState() =>
      _InsertionTraceNumScreenState();
}

class _InsertionTraceNumScreenState extends State<InsertionTraceNumScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InsertionTraceNumViewModel>().initialize();
  }

  @override
  void dispose() {
    context.read<InsertionTraceNumViewModel>().disposeMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: '육류 기본정보',
          backButton: false,
          closeButton: true,
          closeButtonOnPressed: () {
            FocusScope.of(context).unfocus();
            context.pop();
          },
        ),
        body: Column(
          children: [
            SizedBox(height: 49.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: context.read<InsertionTraceNumViewModel>().formKey,
                  child: SizedBox(
                    width: 479.w,
                    height: 85.h,
                    child: TextFormField(
                      controller: context
                          .watch<InsertionTraceNumViewModel>()
                          .textEditingController,
                      textInputAction: TextInputAction.search,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9L]'))
                      ],
                      validator: (value) {
                        if (value!.isEmpty || value.length < 12) {
                          return "유효하지 않습니다!";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        context.read<InsertionTraceNumViewModel>().traceNum =
                            value!;
                      },
                      onChanged: (value) {
                        context.read<InsertionTraceNumViewModel>().traceNum =
                            value;
                      },
                      onFieldSubmitted: (value) {
                        context.read<InsertionTraceNumViewModel>().traceNum =
                            value;
                      },
                      decoration: const InputDecoration(
                        hintText: '이력번호/묶음번호 입력',
                      ),
                      maxLength: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                RoundButton(
                  text: Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPress: () {
                    context.read<InsertionTraceNumViewModel>().start(context);
                  },
                  width: 161.w,
                  height: 85.h,
                  bgColor: Palette.mainButtonColor,
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            if (context.watch<InsertionTraceNumViewModel>().isAllInserted == 1)
              Expanded(
                  child: ListTable(
                      tableData:
                          context.read<InsertionTraceNumViewModel>().tableData))
            else if (context.read<InsertionTraceNumViewModel>().isAllInserted ==
                2)
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 45.0,
                    ),
                    child: Text(
                      '검색결과가 없습니다',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              )
            else if (context.read<InsertionTraceNumViewModel>().isAllInserted ==
                0)
              const Spacer(
                flex: 2,
              ),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: MainButton(
                isWhite: false,
                text: '다음',
                width: 658.w,
                heigh: 104.h,
                onPressed:
                    (context.read<InsertionTraceNumViewModel>().isAllInserted ==
                            1)
                        ? () => context
                            .read<InsertionTraceNumViewModel>()
                            .clickedNextbutton(context)
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTable extends StatelessWidget {
  ListTable({super.key, required this.tableData});

  final List<String?> tableData;
  final List<String> baseData = [
    '이력번호',
    '출생년월일',
    '육종/축종',
    '성별',
    '경영자',
    '사육지',
    '도축일자',
    '등급',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: baseData.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: InnerBox(
                  text: baseData[index],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: (baseData[index] == '사육지' && (tableData[2] != '돼지'))
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InnerBox(
                          text: tableData[index],
                        ),
                      )
                    : InnerBox(
                        text:
                            (tableData[index] != null) ? tableData[index] : "",
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
