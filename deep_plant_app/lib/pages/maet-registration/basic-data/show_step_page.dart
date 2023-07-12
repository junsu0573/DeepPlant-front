import 'dart:convert';
import 'dart:io';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class ShowStep extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  ShowStep({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<ShowStep> createState() => _ShowStepState();
}

class _ShowStepState extends State<ShowStep> {
  bool _isAllCompleted() {
    if (widget.meatData.speciesValue != null &&
        widget.meatData.imagePath != null &&
        widget.meatData.freshmeat != null) {
      return true;
    }
    return false;
  }

  // 임시 데이터를 로컬 임시 파일로 저장
  Future<void> saveDataToLocal(Map<String, dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/${widget.userData.userId}/basic_temp_data.json');

    await file.writeAsString(jsonEncode(data));
  }

  // 객체 데이터를 임시 저장 데이터로 초기화
  Future<void> initMeatData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file =
        File('${directory.path}/${widget.userData.userId}/temp_data.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);

      // 육류 오픈 API 데이터
      widget.meatData.traceNum = data['traceNum'];
      widget.meatData.farmAddr = data['farmAddr'];
      widget.meatData.farmerNm = data['farmerNm'];
      widget.meatData.butcheryYmd = data['butcheryYmd'];
      widget.meatData.birthYmd = data['birthYmd'];
      widget.meatData.sexType = data['sexType'];
      widget.meatData.lsType = data['lsType'];
      widget.meatData.gradeNum = data['gradeNum'];

      // 육류 추가 정보
      widget.meatData.speciesValue = data['speciesValue'];
      widget.meatData.primalValue = data['primalValue'];
      widget.meatData.secondaryValue = data['secondaryValue'];

      // 육류 이미지 경로
      widget.meatData.imagePath = data['imagePath'];

      // 신선육 관능평가
      if (data['freshData'] != null) {
        widget.meatData.freshmeat = data['freshmeat']?.cast<String, double>();
      } else {
        widget.meatData.freshmeat = null;
      }
    }
  }

  // 임시저장 데이터 저장
  Future<void> saveTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      // 육류 오픈 API 데이터
      'traceNum': widget.meatData.traceNum,
      'farmAddr': widget.meatData.farmAddr,
      'farmerNm': widget.meatData.farmerNm,
      'butcheryYmd': widget.meatData.butcheryYmd,
      'birthYmd': widget.meatData.birthYmd,
      'sexType': widget.meatData.sexType,
      'lsType': widget.meatData.lsType,
      'gradeNum': widget.meatData.gradeNum,

      // 육류 추가 정보
      'speciesValue': widget.meatData.speciesValue,
      'primalValue': widget.meatData.primalValue,
      'secondaryValue': widget.meatData.secondaryValue,

      // 육류 이미지 경로
      'imagePath': widget.meatData.imagePath,

      // 신선육 관능평가
      'freshmeat': widget.meatData.freshmeat,
    };
    await saveDataToLocal(tempBasicData);
  }

  // 임시저장 데이터 리셋
  Future<void> resetTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      // 육류 오픈 API 데이터
      'traceNum': null,
      'farmAddr': null,
      'farmerNm': null,
      'butcheryYmd': null,
      'birthYmd': null,
      'sexType': null,
      'lsType': null,
      'gradeNum': null,

      // 육류 추가 정보
      'speciesValue': null,
      'primalValue': null,
      'secondaryValue': null,

      // 육류 이미지 경로
      'imagePath': null,

      // 신선육 관능평가
      'freshmeat': null,
    };

    await saveDataToLocal(tempBasicData);
  }

  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await initMeatData().then((_) {
      setState(() {});
    });

    if (widget.meatData.speciesValue != null ||
        widget.meatData.imagePath != null &&
            widget.meatData.freshmeat != null) {
      if (!mounted) return;
      // 임시저장 데이터가 null값이 아닐 때 다이얼로그 호출
      showDataRegisterDialog(context, () async {
        // 처음부터
        resetTempData();
        await initMeatData().then((_) {
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
  void initState() async {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
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
          showExitDialog(
            context,
            () => initMeatData(),
          );
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
              onTap: () async {
                context.go('/option/show-step/insert-his-num');
              },
              child: StepCard(
                mainText: '육류 기본정보 입력',
                subText: '데이터를 입력해 주세요.',
                step: '1',
                isCompleted:
                    widget.meatData.speciesValue != null ? true : false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () => context.go('/option/show-step/insert-meat-image'),
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meatData.imagePath != null ? true : false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: () =>
                  context.go('/option/show-step/insert-fresh-evaluation'),
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '3',
                isCompleted: widget.meatData.freshmeat != null ? true : false,
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
                        () {
                          saveTempData();
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
                        ? () {
                            resetTempData();
                            widget.userData.type == 'Normal'
                                ? context.go('/option/complete-register')
                                : context.go('/option/complete-register-2');
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
