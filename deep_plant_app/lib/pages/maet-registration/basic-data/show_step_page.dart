import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/fresh_meat_evaluation_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/get_trace_num_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/insertion_meat_image.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShowStep extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  final bool isEdited;
  ShowStep({
    super.key,
    required this.userData,
    required this.meatData,
    required this.isEdited,
  });

  @override
  State<ShowStep> createState() => _ShowStepState();
}

class _ShowStepState extends State<ShowStep> {
  String _userId = '';

  @override
  void initState() {
    super.initState();
    if (widget.isEdited != true) {
      // 육류 정보 초기화
      widget.meatData.resetData();
      widget.meatData.seqno = 0;

      // 유저 아이디 저장
      if (widget.userData.userId != null) {
        _userId = widget.userData.userId!;
        widget.meatData.userId = _userId;
      }

      // 임시저장 처리
      WidgetsBinding.instance.addPostFrameCallback((_) {
        initialize();
      });
    } else {
      // 유저 아이디 저장
      if (widget.userData.userId != null) {
        _userId = widget.userData.userId!;
        widget.meatData.userId = _userId;
      }
    }
  }

  bool _isAllCompleted() {
    if (widget.meatData.speciesValue != null && widget.meatData.imagePath != null && widget.meatData.freshmeat != null) {
      return true;
    }
    return false;
  }

  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await widget.meatData.initMeatData(_userId).then((_) {
      setState(() {});
    });

    if (widget.meatData.speciesValue != null || widget.meatData.imagePath != null && widget.meatData.freshmeat != null) {
      if (!mounted) return;
      // 임시저장 데이터가 null값이 아닐 때 다이얼로그 호출
      showDataRegisterDialog(context, () async {
        // 처음부터
        await widget.meatData.resetTempData();
        await widget.meatData.initMeatData(_userId).then((_) {
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

  void asyncPaging() async {
    final temp = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetTraceNum(
          meatData: widget.meatData,
        ),
      ),
    );
    if (temp != null) {
      setState(() {});
    } else {
      print('null');
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
        closeButtonOnPressed: () {
          showExitDialog(context, () async {
            await widget.meatData.initMeatData(_userId);
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '육류 등록',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 105.h,
            ),
            InkWell(
              onTap: () {
                print(widget.meatData.imagePath);
                print(widget.meatData.createdAt);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetTraceNum(
                      meatData: widget.meatData,
                    ),
                  ),
                ).then((value) {
                  setState(() {});
                });
              },
              child: StepCard(
                mainText: '육류 기본정보 입력',
                subText: '육류 정보를 입력해 주세요.',
                step: '1',
                isCompleted: widget.meatData.secondaryValue != null ? true : false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => widget.meatData.secondaryValue != null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsertionMeatImage(
                          userData: widget.userData,
                          meatData: widget.meatData,
                          imageIdx: 0,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    })
                  : null,
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: widget.meatData.secondaryValue != null ? '육류 단면을 촬영해 주세요.' : '육류 기본정보 입력 후 진행해주세요.',
                step: '2',
                isCompleted: widget.meatData.imagePath != null ? true : false,
                isBefore: widget.meatData.secondaryValue == null,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => widget.meatData.imagePath != null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FreshMeatEvaluation(
                          meatData: widget.meatData,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    })
                  : null,
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: widget.meatData.imagePath != null ? '육류 관능평가를 진행해 주세요.' : '육류 단면 촬영 완료 후 진행해주세요.',
                step: '3',
                isCompleted: widget.meatData.freshmeat != null ? true : false,
                isBefore: widget.meatData.imagePath == null,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SaveButton(
                    onPressed: () {
                      showTemporarySaveDialog(
                        context,
                        () async {
                          await widget.meatData.saveTempData();
                          if (!mounted) return;
                          context.pop();
                        },
                      );
                    },
                    text: '임시저장',
                    width: 310.w,
                    heigh: 104.h,
                    isWhite: true,
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  SaveButton(
                    onPressed: _isAllCompleted()
                        ? () async {
                            await widget.meatData.resetTempData();
                            if (!mounted) return;
                            print(widget.meatData.createdAt);
                            widget.userData.type == 'Normal' ? context.go('/option/complete-register') : context.go('/option/complete-register-2');
                          }
                        : null,
                    text: '저장',
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
