import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/get_date.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/title_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/eval_buttonnrow.dart';
import 'package:go_router/go_router.dart';

class HeatedMeatEvaluation extends StatefulWidget {
  final MeatData meatData;

  const HeatedMeatEvaluation({
    super.key,
    required this.meatData,
  });

  @override
  State<HeatedMeatEvaluation> createState() => HeatedMeatEvaluationState();
}

class HeatedMeatEvaluationState extends State<HeatedMeatEvaluation> {
  // 5개 평가 항목을 모두 false로 설정(기본값)
  final List<bool> _selectedFlavor = List.filled(5, false);
  final List<bool> _selectedJuiciness = List.filled(5, false);
  final List<bool> _selectedTenderness = List.filled(5, false);
  final List<bool> _selectedUmami = List.filled(5, false);
  final List<bool> _selectedPalatability = List.filled(5, false);
  final ScrollController _scrollController = ScrollController(); //화면 오른쪽에 스크롤러

  bool _isAllselected() {
    if (_selectedFlavor.contains(true) &&
        _selectedJuiciness.contains(true) &&
        _selectedTenderness.contains(true) &&
        _selectedUmami.contains(true) &&
        _selectedPalatability.contains(true)) {
      return true;
    }
    return false;
  }

  void saveMeatData() {
    // 사용자가 선택한 값(true)의 index에 1을 더한다.
    // ex) (없음:1,약간있음:2, 보통:3, 약간많음:4, 많음:5)
    double flavorIndex = _selectedFlavor.indexOf(true) + 1;
    double juicinessIndex = _selectedJuiciness.indexOf(true) + 1;
    double tendernessIndex = _selectedTenderness.indexOf(true) + 1;
    double umamiIndex = _selectedUmami.indexOf(true) + 1;
    double palatabilityIndex = _selectedPalatability.indexOf(true) + 1;

    // 데이터 생성
    Map<String, dynamic> heatedData = {
      'createdAt': GetDate.getCurrentDate(),
      'period': widget.meatData.getPeriod(),
      'flavor': flavorIndex,
      'juiciness': juicinessIndex,
      'tenderness': tendernessIndex,
      'umami': umamiIndex,
      'palability': palatabilityIndex,
    };

    // 데이터를 객체에 저장
    widget.meatData.heatedmeat = heatedData;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //////////////// data list
    List<EvalData> evalDataList = [
      EvalData(
        title: 'Flavor',
        desc: '풍미',
        isSelected: _selectedFlavor,
        text: ['약간', '', '약간 풍부함', '', '풍부함'],
      ),
      EvalData(
        title: 'Juiciness',
        desc: '다즙성',
        isSelected: _selectedJuiciness,
        text: ['퍽퍽함', '', '보통', '', '다즙합'],
      ),
      EvalData(
        title: 'Tenderness',
        desc: '연도',
        isSelected: _selectedTenderness,
        text: ['질김', '', '보통', '', '연함'],
      ),
      EvalData(
        title: 'Umami',
        desc: '표면육즙',
        isSelected: _selectedUmami,
        text: ['약함', '', '보통', '', '좋음'],
      ),
      EvalData(
        title: 'Palatability',
        desc: '기호도',
        isSelected: _selectedPalatability,
        text: ['나쁨', '', '보통', '', '좋음'],
      ),
    ];
    ///////////  data list
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
        closeButtonOnPressed: () {
          showExitDialog(context, null);
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55.w),
              child: Column(
                children: [
                  Text(
                    '가열육 관능평가 데이터',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.22,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  for (var evalData in evalDataList)
                    Column(
                      children: [
                        TitleDesc(title: evalData.title, desc: evalData.desc),
                        EvalRow(
                          isSelected: evalData.isSelected,
                          onEvalButtonPressed: (index) {
                            setState(() {
                              for (int i = 0;
                                  i < evalData.isSelected.length;
                                  i++) {
                                evalData.isSelected[i] = i == index;
                              }
                            });
                          },
                          text: evalData.text,
                        ),
                      ],
                    ),
                  SizedBox(height: 101.h),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: SaveButton(
                onPressed: _isAllselected()
                    ? () async {
                        // 객체 데이터 저장
                        saveMeatData();

                        // 데이터 서버로 전송
                        await ApiServices.sendMeatData('heatedmeat_eval',
                            widget.meatData.convertHeatedMeatToJson());

                        if (!mounted) return;
                        context.pop();
                      }
                    : null,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                isWhite: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EvalData {
  final String title;
  final String desc;
  final List<bool> isSelected;
  final List<String> text;

  EvalData({
    required this.title,
    required this.desc,
    required this.isSelected,
    required this.text,
  });
}
