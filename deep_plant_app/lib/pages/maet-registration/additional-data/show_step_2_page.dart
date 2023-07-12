import 'dart:convert';
import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

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
        widget.meat.freshData != null &&
        widget.meat.heatedMeat != null &&
        widget.meat.tongueData != null &&
        widget.meat.labData != null) {
      return true;
    }
    return false;
  }

  // 임시 데이터를 로컬 임시 파일로 저장
  Future<void> saveDataToLocal(Map<String, dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/temp_data_2.json');

    await file.writeAsString(jsonEncode(data));
  }

  // 객체 데이터를 임시 저장 데이터로 초기화
  Future<void> initMeatdata() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/temp_data.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);

      widget.meat.deepAging = data['deepAging'];
      if (data['freshData'] != null) {
        widget.meat.freshData = data['freshData']?.cast<String, double>();
      } else {
        widget.meat.freshData = null;
      }
      if (data['heatedMeat'] != null) {
        widget.meat.heatedMeat = data['heatedMeat']?.cast<String, double>();
      } else {
        widget.meat.heatedMeat = null;
      }
      if (data['tongueData'] != null) {
        widget.meat.tongueData = data['tongueData']?.cast<String, double>();
      } else {
        widget.meat.tongueData = null;
      }
      if (data['labData'] != null) {
        widget.meat.labData = data['labData']?.cast<String, double>();
      } else {
        widget.meat.labData = null;
      }
    }
  }

  // 임시저장 데이터 저장
  Future<void> saveTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'deepAging': widget.meat.historyNumber,
      'heatedMeat': widget.meat.species,
      'tongueData': widget.meat.lDivision,
      'labData': widget.meat.sDivision,
    };
    await saveDataToLocal(tempBasicData);
  }

  // 임시저장 데이터 리셋
  Future<void> resetTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'deepAging': null,
      'heatedMeat': null,
      'tongueData': null,
      'labData': null,
    };

    await saveDataToLocal(tempBasicData);
  }

  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await initMeatdata().then((_) {
      setState(() {});
    });

    if (widget.meat.deepAging != null ||
        widget.meat.freshData != null ||
        widget.meat.heatedMeat != null ||
        widget.meat.tongueData != null && widget.meat.labData != null) {
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
    setState(() {});
    initialize();
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
              onTap: () => context.go('/option/show-step-2/tongue-data'),
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '데이터를 입력해 주세요.',
                step: '4',
                isCompleted: widget.meat.tongueData != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step-2/experiment-data'),
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
