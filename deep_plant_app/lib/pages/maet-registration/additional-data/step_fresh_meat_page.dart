import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StepFreshMeat extends StatefulWidget {
  final MeatData meat;
  const StepFreshMeat({
    super.key,
    required this.meat,
  });

  @override
  State<StepFreshMeat> createState() => _StepFreshMeatState();
}

class _StepFreshMeatState extends State<StepFreshMeat> {
  bool _isAllCompleted() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
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
            GestureDetector(
              onTap: () => context.go('/option/show-step/insert-meat-image'),
              child: StepCard(
                mainText: '가열육 단면 촬영',
                subText: '데이터를 입력해주세요',
                step: '1',
                isCompleted: widget.meat.imagePath != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/heated-meat-data'),
              child: StepCard(
                mainText: '가열육 관능평가',
                subText: '데이터를 입력해주세요',
                step: '2',
                isCompleted: widget.meat.heatedmeat != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/tongue-data'),
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '데이터를 입력해주세요',
                step: '3',
                isCompleted: widget.meat.tongueData != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/experiment-data'),
              child: StepCard(
                mainText: '실험 데이터',
                subText: '데이터를 입력해주세요',
                step: '4',
                isCompleted: widget.meat.labData != null ? true : false,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SaveButton(
                    onPressed: _isAllCompleted() ? () {} : null,
                    text: '다음',
                    width: 620.w,
                    heigh: 104.h,
                    isWhite: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
