import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/part_eval.dart';
import 'package:structure/viewModel/data_management/researcher/heatedmeat_eval_view_model.dart';

class HeatedMeatEvaluation extends StatefulWidget {
  const HeatedMeatEvaluation({super.key});

  @override
  State<HeatedMeatEvaluation> createState() => _HeatedMeatEvaluation();
}

class _HeatedMeatEvaluation extends State<HeatedMeatEvaluation>
    with SingleTickerProviderStateMixin {
  List<List<String>> text = [
    ['Flavor', '풍미', '약간', '', '약간 풍부함', '', '풍부함'],
    ['Juiciness', '다즙성', '퍽퍽함', '', '보통', '', '다즙합'],
    ['Tenderness', '연도', '질김', '', '보통', '', '연함'],
    ['Umami', '표면육즙', '약함', '', '보통', '', '좋음'],
    ['Palatability', '기호도', '나쁨', '', '보통', '', '좋음'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '가열육관능평가',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                PartEval(
                  selectedText: text[0],
                  value: context.watch<HeatedMeatEvalViewModel>().flavor,
                  onChanged: (value) => context
                      .read<HeatedMeatEvalViewModel>()
                      .onChangedFlavor(value),
                ),
                SizedBox(
                  height: 50.h,
                ),
                PartEval(
                  selectedText: text[1],
                  value: context.read<HeatedMeatEvalViewModel>().juiciness,
                  onChanged: (value) => context
                      .read<HeatedMeatEvalViewModel>()
                      .onChangedJuiciness(value),
                ),
                SizedBox(
                  height: 50.h,
                ),
                PartEval(
                  selectedText: text[2],
                  value: context.read<HeatedMeatEvalViewModel>().tenderness,
                  onChanged: (value) => context
                      .read<HeatedMeatEvalViewModel>()
                      .onChangedTenderness(value),
                ),
                SizedBox(
                  height: 50.h,
                ),
                PartEval(
                  selectedText: text[3],
                  value: context.read<HeatedMeatEvalViewModel>().umami,
                  onChanged: (value) => context
                      .read<HeatedMeatEvalViewModel>()
                      .onChangedUmami(value),
                ),
                SizedBox(
                  height: 50.h,
                ),
                PartEval(
                  selectedText: text[4],
                  value: context.read<HeatedMeatEvalViewModel>().palatability,
                  onChanged: (value) => context
                      .read<HeatedMeatEvalViewModel>()
                      .onChangedPalatability(value),
                ),
                SizedBox(
                  height: 120.h,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 18.h),
                  child: MainButton(
                    onPressed: () => context
                        .read<HeatedMeatEvalViewModel>()
                        .saveData(context),
                    text: '저장',
                    width: 658.w,
                    heigh: 104.h,
                    isWhite: false,
                  ),
                ),
              ],
            ),
            context.watch<HeatedMeatEvalViewModel>().isLoading
                ? const CircularProgressIndicator()
                : Container()
          ],
        ),
      ),
    );
  }
}
