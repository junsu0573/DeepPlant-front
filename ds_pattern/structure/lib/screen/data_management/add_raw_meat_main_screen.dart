import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/step_card.dart';
import 'package:structure/viewModel/data_management/add_raw_meat_view_model.dart';

class StepFreshMeat extends StatelessWidget {
  const StepFreshMeat({super.key});

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
              onTap: () =>
                  context.read<AddRawMeatViewModel>().clickedHeated(context),
              child: const StepCard(
                mainText: '가열육 관능평가',
                subText: '가열육 관능평가를 입력해주세요',
                step: '1',
                isCompleted: false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () =>
                  context.read<AddRawMeatViewModel>().clickedTongue(context),
              child: const StepCard(
                mainText: '전자혀 데이터',
                subText: '전자혀 측정 데이터를 입력해주세요',
                step: '2',
                isCompleted: false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () =>
                  context.read<AddRawMeatViewModel>().clickedLab(context),
              child: const StepCard(
                mainText: '실험 데이터',
                subText: '실험 결과 데이터를 입력해주세요',
                step: '3',
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
