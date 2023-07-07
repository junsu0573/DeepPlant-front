import 'dart:convert';
import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ShowStep extends StatefulWidget {
  final UserModel user;
  final MeatData meat;
  ShowStep({
    super.key,
    required this.user,
    required this.meat,
  });

  @override
  State<ShowStep> createState() => _ShowStepState();
}

class _ShowStepState extends State<ShowStep> {
  bool _isAllCompleted() {
    if (widget.meat.species != null &&
        widget.meat.imageFile != null &&
        widget.meat.freshData != null) {
      return true;
    }
    return false;
  }

  // 임시 데이터를 로컬 임시 파일로 저장
  Future<void> saveDataToLocal(Map<String, dynamic> data) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/temp_data.json');

    await file.writeAsString(jsonEncode(data));
  }

  // 객체 데이터를 임시 저장 데이터로 초기화
  Future<void> initMeatdata() async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/temp_data.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);

      widget.meat.historyNumber = data['historyNumber'];
      widget.meat.species = data['species'];
      widget.meat.lDivision = data['lDivision'];
      widget.meat.sDivision = data['sDivision'];
      if (data['freshData'] != null) {
        widget.meat.freshData = data['freshData']?.cast<String, double>();
      } else {
        widget.meat.freshData = null;
      }
      widget.meat.gradeNm = data['gradeNm'];
      widget.meat.farmAddr = data['farmAddr'];
      widget.meat.butcheryPlaceNm = data['butcheryPlaceNm'];
      widget.meat.butcheryYmd = data['butcheryYmd'];
      widget.meat.imageFile = data['imageFile'];
    }
  }

  // 임시저장 데이터 저장
  Future<void> saveTempData() async {
    DateTime now = DateTime.now();

    String saveDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'historyNumber': widget.meat.historyNumber,
      'species': widget.meat.species,
      'lDivision': widget.meat.lDivision,
      'sDivision': widget.meat.sDivision,
      'saveTime': saveDate,
      'gradeNm': widget.meat.gradeNm,
      'farmAddr': widget.meat.farmAddr,
      'butcheryPlaceNm': widget.meat.butcheryPlaceNm,
      'butcheryYmd': widget.meat.butcheryYmd,
      'freshData': widget.meat.freshData,
      'imageFile': widget.meat.imageFile,
    };
    await saveDataToLocal(tempBasicData);
  }

  // 임시저장 데이터 리셋
  Future<void> resetTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'historyNumber': null,
      'species': null,
      'lDivision': null,
      'sDivision': null,
      'gradeNm': null,
      'farmAddr': null,
      'butcheryPlaceNm': null,
      'butcheryYmd': null,
      'freshData': null,
      'imageFile': null,
    };

    await saveDataToLocal(tempBasicData);
  }

  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await initMeatdata().then((_) {
      setState(() {});
    });

    if (widget.meat.historyNumber != null) {
      if (!mounted) return;
      // 임시저장 데이터가 null값이 아닐 때 다이얼로그 호출
      showDataRegisterDialog(context, () async {
        // 처음부터
        resetTempData();
        await initMeatdata().then((_) {
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
  void initState() {
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
            () => initMeatdata(),
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
            GestureDetector(
              onTap: () async {
                context.go('/option/show-step/insert-his-num');
              },
              child: StepCard(
                mainText: '육류 기본정보 입력',
                subText: '데이터를 입력해 주세요.',
                step: '1',
                isCompleted: widget.meat.species != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step/insert-meat-image'),
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meat.imageFile != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () =>
                  context.go('/option/show-step/insert-fresh-evaluation'),
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '3',
                isCompleted: widget.meat.freshData != null ? true : false,
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
                            widget.user.level == 'users_1'
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
