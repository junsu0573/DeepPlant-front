import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/step_card.dart';
import 'package:structure/main.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/viewModel/data_management/add_processed_meat_view_model.dart';

class AddProcessedMeatMainScreen extends StatefulWidget {
  final MeatModel meatModel;
  const AddProcessedMeatMainScreen({
    super.key,
    required this.meatModel,
  });

  @override
  State<AddProcessedMeatMainScreen> createState() =>
      _AddProcessedMeatMainScreenState();
}

class _AddProcessedMeatMainScreenState
    extends State<AddProcessedMeatMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '추가정보 입력',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            InkWell(
              onTap: () => context
                  .read<AddProcessedMeatViewModel>()
                  .clickedImage(context),
              child: StepCard(
                mainText: '처리육 단면 촬영',
                subText: '육류 단면을 촬영해주세요',
                step: '1',
                isCompleted: meatModel.deepAgedImage != null,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => widget.meatModel.deepAgedImage != null
                  ? context
                      .read<AddProcessedMeatViewModel>()
                      .clickedProcessedEval(context)
                  : null,
              child: StepCard(
                mainText: '처리육 관능평가',
                subText: widget.meatModel.deepAgedImage != null
                    ? '육류 관능평가를 진행해주세요'
                    : '육류 단면 촬영 완료 후 진행해주세요',
                step: '2',
                isCompleted: false,
                isBefore: widget.meatModel.deepAgedImage == null,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => context
                  .read<AddProcessedMeatViewModel>()
                  .clickedHeatedEval(context),
              child: const StepCard(
                mainText: '가열육 관능평가',
                subText: '육류 관능평가를 진행해주세요',
                step: '3',
                isCompleted: false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => context
                  .read<AddProcessedMeatViewModel>()
                  .clickedTongue(context),
              child: const StepCard(
                mainText: '전자혀 데이터',
                subText: '전자혀 측정 데이터를 입력해주세요',
                step: '4',
                isCompleted: false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () =>
                  context.read<AddProcessedMeatViewModel>().clickedLab(context),
              child: const StepCard(
                mainText: '실험 데이터',
                subText: '실험 결과 데이터를 입력해주세요',
                step: '5',
                isCompleted: false,
                isBefore: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
