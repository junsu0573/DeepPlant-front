import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowStep extends StatefulWidget {
  final MeatData meat;
  ShowStep({
    super.key,
    required this.meat,
  });

  @override
  State<ShowStep> createState() => _ShowStepState();
}

class _ShowStepState extends State<ShowStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '육류 등록',
        backButton: false,
        closeButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step/insert-his-num'),
              child: StepCard(
                mainText: '육류 기본정보 입력',
                subText: '데이터를 입력해 주세요.',
                step: '1',
                isCompleted: widget.meat.historyNumber != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step/logged-in'),
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meat.date != null ? true : false,
              ),
            ),
            StepCard(
              mainText: '신선육 관능평가',
              subText: '데이터를 입력해 주세요.',
              step: '3',
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }
}
