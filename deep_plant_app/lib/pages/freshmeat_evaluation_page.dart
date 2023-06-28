import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/widgets/custom_dialog.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/title_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/eval_buttonnrow.dart';

class FreshmeatEvaluationpage extends StatefulWidget {
  const FreshmeatEvaluationpage({Key? key}) : super(key: key);

  @override
  State<FreshmeatEvaluationpage> createState() =>
      _FreshmeatEvaluationpageState();
}

class _FreshmeatEvaluationpageState extends State<FreshmeatEvaluationpage> {
  // 5개 평가 항목을 모두 false로 설정(기본값)
  final List<bool> _selectedMabling = List.filled(5, false);
  final List<bool> _selectedColor = List.filled(5, false);
  final List<bool> _selectedTexture = List.filled(5, false);
  final List<bool> _selectedSurfaceMoisture = List.filled(5, false);
  final List<bool> _selectedOverall = List.filled(5, false);
  final ScrollController _scrollController = ScrollController(); //화면 오른쪽에 스크롤러

  void _sendEvaluation() async {
    //firebase에 데이터 전송하는 '저장' 버튼 기능

    // 사용자가 선택한 값(true)의 index에 1을 더한다.
    // ex) (없음:1,약간있음:2, 보통:3, 약간많음:4, 많음:5)
    double mablingIndex = _selectedMabling.indexOf(true) + 1;
    double colorIndex = _selectedColor.indexOf(true) + 1;
    double textureIndex = _selectedTexture.indexOf(true) + 1;
    double surfaceMoistureIndex = _selectedSurfaceMoisture.indexOf(true) + 1;
    double overallIndex = _selectedOverall.indexOf(true) + 1;

    Map<String, dynamic> freshData = {
      //데이터를 Map 형식으로 지정
      'Mabling': mablingIndex,
      'Color': colorIndex,
      'Texture': textureIndex,
      'SurfaceMoisture': surfaceMoistureIndex,
      'Overall': overallIndex,
    };

    Map<String, dynamic> newData = {
      'meat': freshData,
      'users-1': [],
      'users-2': [],
      'users-3': [],
    };

    //firebase
    await FirebaseFirestore.instance
        .collection('meat')
        .doc('0-0-0-0-0')
        .update({'fix_data': newData});
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
      appBar: CustomAppBar(
        title: '',
        back_button: false,
        close_button: true,
        backButtonOnPressed: () {
          //customDialog(context);
        },
        closeButtonOnPressed: () {
          CustomDialog(context);
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
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
                          for (int i = 0; i < evalData.isSelected.length; i++) {
                            evalData.isSelected[i] = i == index;
                          }
                        });
                      },
                      text: evalData.text,
                    ),
                  ],
                ),
              SizedBox(height: 101.h),
              SaveButton(onPressed: _sendEvaluation)
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
