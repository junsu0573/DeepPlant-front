import 'dart:io';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/get_date.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/eval_buttonnrow.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FreshMeatEvaluation extends StatefulWidget {
  final MeatData meatData;
  final bool? isDeepAged;
  const FreshMeatEvaluation({
    super.key,
    required this.meatData,
    this.isDeepAged,
  });

  @override
  State<FreshMeatEvaluation> createState() => _FreshMeatEvaluationState();
}

class _FreshMeatEvaluationState extends State<FreshMeatEvaluation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _meatImage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    if (widget.isDeepAged != null && widget.isDeepAged == true) {
      _meatImage = widget.meatData.deepAgedImage!;
    } else {
      _meatImage = widget.meatData.imagePath!;
    }
  }

  List<List<String>> text = [
    ['Mabling', '마블링 정도', '없음', '', '보통', '', '많음'],
    ['Color', '육색', '없음', '', '보통', '', '어둡고 진함'],
    ['Texture', '조직감', '흐물함', '', '보통', '', '단단함'],
    ['Surface Moisture', '표면육즙', '없음', '', '보통', '', '많음'],
    ['Overall', '종합기호도', '나쁨', '', '보통', '', '좋음'],
  ];

  double _marbling = 0;
  double _color = 0;
  double _texture = 0;
  double _surface = 0;
  double _overall = 0;

  bool _isAllInserted() {
    if (_marbling > 0 &&
        _color > 0 &&
        _texture > 0 &&
        _surface > 0 &&
        _overall > 0) return true;
    return false;
  }

  void saveMeatData() {
    //데이터를 Map 형식으로 저장
    Map<String, dynamic> freshData = {
      'createdAt': GetDate.getCurrentDate(),
      'period': widget.meatData.getPeriod(),
      'marbling': _marbling,
      'color': _color,
      'texture': _texture,
      'surfaceMoisture': _surface,
      'overall': _overall,
    };

    // 데이터를 객체에 저장
    if (widget.isDeepAged != null) {
      widget.meatData.deepAgedFreshmeat = freshData;
    } else {
      widget.meatData.freshmeat = freshData;
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '신선육관능평가',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 46.h),
              Container(
                width: 600.w,
                height: 600.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(
                      File(_meatImage),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: '1',
                    ),
                    Tab(
                      text: '2',
                    ),
                    Tab(
                      text: '3',
                    ),
                    Tab(
                      text: '4',
                    ),
                    Tab(
                      text: '5',
                    ),
                  ],
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(120, 120, 120, 1),
                  ),
                  indicator: ShapeDecoration(
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3.0.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 300.h,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab1의 내용
                    Center(
                      child: PartEval(
                        selectedText: text[0],
                        value: _marbling,
                        onChanged: (value) {
                          setState(() {
                            _marbling = double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                    // Tab2의 내용
                    Center(
                      child: PartEval(
                        selectedText: text[1],
                        value: _color,
                        onChanged: (value) {
                          setState(() {
                            _color = double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                    // Tab3의 내용
                    Center(
                      child: PartEval(
                        selectedText: text[2],
                        value: _texture,
                        onChanged: (value) {
                          setState(() {
                            _texture = double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                    // Tab4의 내용
                    Center(
                      child: PartEval(
                        selectedText: text[3],
                        value: _surface,
                        onChanged: (value) {
                          setState(() {
                            _surface = double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                    // Tab5의 내용
                    Center(
                      child: PartEval(
                        selectedText: text[4],
                        value: _overall,
                        onChanged: (value) {
                          setState(() {
                            _overall = double.parse(value.toStringAsFixed(1));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 18.h),
                child: SaveButton(
                  onPressed: _isAllInserted()
                      ? () async {
                          // 데이터 저장
                          saveMeatData();

                          if (widget.isDeepAged != null &&
                              widget.isDeepAged == true) {
                            // 서버로 전송
                            await ApiServices.sendMeatData('sensory_eval',
                                widget.meatData.convertFreshMeatToJson(1));
                          }
                          if (!mounted) return;
                          Navigator.pop(context);
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
      ),
    );
  }
}

class PartEval extends StatelessWidget {
  PartEval({
    super.key,
    required this.value,
    required this.selectedText,
    required this.onChanged,
  });

  final List<String>? selectedText;
  final double value;
  final Function(dynamic value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 60.w),
          child: Row(
            children: [
              Text(
                selectedText![0],
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                selectedText![1],
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Palette.greyTextColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.5.w),
                child: EvalButton(
                  backgroundColor: [
                    Color(0xFFEFEFEF),
                    Color(0xFFD9D9D9),
                    Color(0xFFB0B0B0),
                    Color(0xFF6F6F6F),
                    Color(0xFF363636),
                  ][i],
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 2; i < 7; i++)
              SizedBox(
                width: 123.w,
                child: Text(
                  selectedText![i],
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        Container(
          width: 640.w,
          height: 50.h,
          margin: EdgeInsets.only(top: 8.h, right: 60.w),
          child: SfSlider(
            min: 0.0,
            max: 9,
            value: value,
            interval: 1,
            showTicks: true,
            showLabels: true,
            activeColor: Palette.mainButtonColor,
            inactiveColor: Palette.subButtonColor,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
