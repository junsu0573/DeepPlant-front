import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShowStep2 extends StatefulWidget {
  final UserModel user;
  final MeatData meat;
  ShowStep2({
    super.key,
    required this.user,
    required this.meat,
  });

  @override
  State<ShowStep2> createState() => _ShowStep2State();
}

class _ShowStep2State extends State<ShowStep2> {
  bool _isAllCompleted() {
    if (widget.meat.deepAging != null &&
        widget.meat.heatedMeat != null &&
        widget.meat.tongueData != null &&
        widget.meat.labData != null) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
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
              onTap: () => context.go('/option/show-step-2/deep-aging-data'),
              child: StepCard(
                mainText: '딥에이징 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '1',
                isCompleted: widget.meat.deepAging != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/fresh-meat-data'),
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meat.freshData != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/heated-meat-data'),
              child: StepCard(
                mainText: '가열육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '3',
                isCompleted: widget.meat.heatedMeat != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/hitted-meat-data'),
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '4',
                isCompleted: widget.meat.tongueData != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/tongue-data'),
              child: StepCard(
                mainText: '실험 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '5',
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
                    onPressed: () {},
                    text: '임시저장',
                    width: 310.w,
                    heigh: 104.h,
                    isWhite: true,
                  ),
                  SizedBox(
                    width: 41.w,
                  ),
                  SaveButton(
                    onPressed: _isAllCompleted()
                        ? () {
                            // 등록 완료 페이지로
                          }
                        : null,
                    text: '다음',
                    width: 310.w,
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
