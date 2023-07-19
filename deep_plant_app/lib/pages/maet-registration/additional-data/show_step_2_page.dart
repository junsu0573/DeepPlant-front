import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShowStep2 extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  ShowStep2({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<ShowStep2> createState() => _ShowStep2State();
}

class _ShowStep2State extends State<ShowStep2> {
  String _userId = '';

  @override
  void initState() {
    super.initState();
    // 유저 아이디 저장
    _userId = widget.userData.userId!;
    widget.meatData.userId = _userId;
  }

  bool _isAllCompleted() {
    if (widget.meatData.deepAging != null &&
        widget.meatData.freshmeat != null &&
        widget.meatData.heatedmeat != null &&
        widget.meatData.tongueData != null &&
        widget.meatData.labData != null) {
      return true;
    }
    return false;
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
                isCompleted: widget.meatData.deepAging != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/fresh-meat-data'),
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meatData.freshmeat != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/heated-meat-data'),
              child: StepCard(
                mainText: '가열육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '3',
                isCompleted: widget.meatData.heatedmeat != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/tongue-data'),
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '4',
                isCompleted: widget.meatData.tongueData != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/experiment-data'),
              child: StepCard(
                mainText: '실험 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '5',
                isCompleted: widget.meatData.labData != null ? true : false,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SaveButton(
                    onPressed: _isAllCompleted()
                        ? () async {
                            if (!mounted) {
                              return;
                            }
                            context.go('/option/complete-add-register');
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
