import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/title_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/eval_buttonnrow.dart';
import 'package:go_router/go_router.dart';

class FreshmeatEvaluation extends StatefulWidget {
  final MeatData meatData;
  const FreshmeatEvaluation({
    super.key,
    required this.meatData,
  });

  @override
  State<FreshmeatEvaluation> createState() => _FreshmeatEvaluationState();
}

class _FreshmeatEvaluationState extends State<FreshmeatEvaluation> {
  // 5개 평가 항목을 모두 false로 설정(기본값)
  final List<bool> _selectedMabling = List.filled(5, false);
  final List<bool> _selectedColor = List.filled(5, false);
  final List<bool> _selectedTexture = List.filled(5, false);
  final List<bool> _selectedSurfaceMoisture = List.filled(5, false);
  final List<bool> _selectedOverall = List.filled(5, false);
  final ScrollController _scrollController = ScrollController(); //화면 오른쪽에 스크롤러

  bool _isAllselected() {
    if (_selectedMabling.contains(true) &&
        _selectedColor.contains(true) &&
        _selectedTexture.contains(true) &&
        _selectedSurfaceMoisture.contains(true) &&
        _selectedOverall.contains(true)) {
      return true;
    }
    return false;
  }

  void _sendEvaluation(MeatData meatData) {
    //firebase에 데이터 전송하는 '저장' 버튼 기능

    // 사용자가 선택한 값(true)의 index에 1을 더한다.
    // ex) (없음:1,약간있음:2, 보통:3, 약간많음:4, 많음:5)
    double mablingIndex = _selectedMabling.indexOf(true) + 1;
    double colorIndex = _selectedColor.indexOf(true) + 1;
    double textureIndex = _selectedTexture.indexOf(true) + 1;
    double surfaceMoistureIndex = _selectedSurfaceMoisture.indexOf(true) + 1;
    double overallIndex = _selectedOverall.indexOf(true) + 1;

    Map<String, double> freshData = {
      //데이터를 Map 형식으로 지정
      'marbling': mablingIndex,
      'color': colorIndex,
      'texture': textureIndex,
      'surfaceMoisture': surfaceMoistureIndex,
      'total': overallIndex,
    };

    // 데이터를 객체에 저장
    meatData.freshData = freshData;
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
        title: 'Mabling',
        desc: '마블링 정도',
        isSelected: _selectedMabling,
        text: ['없음', '', '보통', '', '많음'],
      ),
      EvalData(
        title: 'Color',
        desc: '육색',
        isSelected: _selectedColor,
        text: ['없음', '', '보통', '', '어둡고 진함'],
      ),
      EvalData(
        title: 'Texture',
        desc: '조직감',
        isSelected: _selectedTexture,
        text: ['흐물함', '', '보통', '', '단단함'],
      ),
      EvalData(
        title: 'SurfaceMoisture',
        desc: '표면육즙',
        isSelected: _selectedSurfaceMoisture,
        text: ['없음', '', '보통', '', '많음'],
      ),
      EvalData(
        title: 'Overall',
        desc: '종합기호도',
        isSelected: _selectedOverall,
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
        backButtonOnPressed: () {
          //customDialog (context);
        },
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
                    '신선육관능평가',
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
              margin: EdgeInsets.only(bottom: 18.h),
              child: SaveButton(
                onPressed: _isAllselected()
                    ? () {
                        _sendEvaluation(widget.meatData);
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
