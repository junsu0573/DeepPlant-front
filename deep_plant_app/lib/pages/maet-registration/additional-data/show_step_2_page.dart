import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
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

    // 임시저장 처리
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
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

  // 임시저장 처리
  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await widget.meatData.initMeatDataForStep2(_userId).then((_) {
      setState(() {});
    });

    if (widget.meatData.speciesValue != null ||
        widget.meatData.imagePath != null &&
            widget.meatData.freshmeat != null) {
      if (!mounted) return;
      // 임시저장 데이터가 null값이 아닐 때 다이얼로그 호출
      showDataRegisterDialog(context, () async {
        // 처음부터
        widget.meatData.resetTempDataForStep2();
        await widget.meatData.initMeatDataForStep2(_userId).then((_) {
          setState(() {});
        });
        if (!mounted) return;
        context.pop();
      }, () {
        // 이어서
        context.pop();
      });
    }
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
                    onPressed: () async {
                      // 육류 데이터 로컬에 저장
                      await widget.meatData.saveTempDataForStep2();
                    },
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
                        ? () async {
                            await widget.meatData.resetTempDataForStep2();
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
