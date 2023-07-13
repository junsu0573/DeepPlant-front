import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/title_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/eval_buttonnrow.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class FreshmeatEvaluation extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  const FreshmeatEvaluation({
    super.key,
    required this.userData,
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

  // 육류 정보 저장
  void saveMeatData(MeatData meatData) {
    double mablingIndex = _selectedMabling.indexOf(true) + 1;
    double colorIndex = _selectedColor.indexOf(true) + 1;
    double textureIndex = _selectedTexture.indexOf(true) + 1;
    double surfaceMoistureIndex = _selectedSurfaceMoisture.indexOf(true) + 1;
    double overallIndex = _selectedOverall.indexOf(true) + 1;

    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

    //데이터를 Map 형식으로 저장
    Map<String, dynamic> freshData = {
      'createdAt': createdAt,
      'userId': widget.userData.userId,
      'period': null,
      'marbling': mablingIndex,
      'color': colorIndex,
      'texture': textureIndex,
      'surfaceMoisture': surfaceMoistureIndex,
      'overall': overallIndex,
    };

    // 데이터를 객체에 저장
    meatData.freshmeat = freshData;
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
        closeButtonOnPressed: () {
          showExitDialog(context, null);
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: 1400.h,
          child: Column(
            children: [
              Text(
                '신선육관능평가',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
<<<<<<< HEAD
              SizedBox(height: 46.h),
              for (var evalData in evalDataList)
                Column(
                  children: [
                    TitleDesc(title: evalData.title, desc: evalData.desc),
                    SizedBox(
                      height: 10.h,
                    ),
                    EvalRow(
                      isSelected: evalData.isSelected,
                      onEvalButtonPressed: (index) {
                        setState(() {
                          for (int i = 0; i < evalData.isSelected.length; i++) {
                            evalData.isSelected[i] = i == index;
                          }
                        });
                      },
                      text: evalData.text,
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                  ],
                ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 18.h),
                child: SaveButton(
                  onPressed: _isAllselected()
                      ? () {
                          saveMeatData(widget.meatData);
                          context.pop();
                        }
                      : null,
                  text: '저장',
                  width: 658.w,
                  heigh: 104.h,
                  isWhite: false,
                ),
=======
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18.h),
              child: SaveButton(
                onPressed: _isAllselected()
                    ? () {
                        saveMeatData(widget.meatData);
                        context.pop();
                      }
                    : null,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                isWhite: false,
>>>>>>> 7ca8f21 (edit data)
              ),
            ],
          ),
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
