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

class HeatedMeatEvaluation extends StatefulWidget {
  final MeatData meatData;

  const HeatedMeatEvaluation({
    super.key,
    required this.meatData,
  });

  @override
  State<HeatedMeatEvaluation> createState() => _HeatedMeatEvaluation();
}

class _HeatedMeatEvaluation extends State<HeatedMeatEvaluation> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  List<List<String>> text = [
    ['Flavor', '풍미', '약간', '', '약간 풍부함', '', '풍부함'],
    ['Juiciness', '다즙성', '퍽퍽함', '', '보통', '', '다즙합'],
    ['Tenderness', '연도', '질김', '', '보통', '', '연함'],
    ['Umami', '표면육즙', '약함', '', '보통', '', '좋음'],
    ['Palatability', '기호도', '나쁨', '', '보통', '', '좋음'],
  ];

  double _flavor = 0;
  double _juiciness = 0;
  double _tenderness = 0;
  double _umami = 0;
  double _palatability = 0;

  bool _isAllInserted() {
    if (_flavor > 0 && _juiciness > 0 && _tenderness > 0 && _umami > 0 && _palatability > 0) return true;
    return false;
  }

  void initialize() {
    if (widget.meatData.heatedmeat!['flavor'] != null) {
      _flavor = widget.meatData.heatedmeat!['flavor'];
      _juiciness = widget.meatData.heatedmeat!['juiciness'];
      _tenderness = widget.meatData.heatedmeat!['tenderness'];
      _umami = widget.meatData.heatedmeat!['umami'];
      _palatability = widget.meatData.heatedmeat!['palability'];
    }
  }

  void saveMeatData() {
    // 데이터 생성
    Map<String, dynamic> heatedData = {
      'createdAt': GetDate.getCurrentDate(),
      'period': widget.meatData.getPeriod(),
      'flavor': _flavor,
      'juiciness': _juiciness,
      'tenderness': _tenderness,
      'umami': _umami,
      'palability': _palatability,
    };

    // 데이터를 객체에 저장
    widget.meatData.heatedmeat = heatedData;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '가열육관능평가',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            PartEval(
              selectedText: text[0],
              value: _flavor,
              onChanged: (value) {
                setState(() {
                  _flavor = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            PartEval(
              selectedText: text[1],
              value: _juiciness,
              onChanged: (value) {
                setState(() {
                  _juiciness = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            PartEval(
              selectedText: text[2],
              value: _tenderness,
              onChanged: (value) {
                setState(() {
                  _tenderness = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            PartEval(
              selectedText: text[3],
              value: _umami,
              onChanged: (value) {
                setState(() {
                  _umami = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            SizedBox(
              height: 50.h,
            ),
            PartEval(
              selectedText: text[4],
              value: _palatability,
              onChanged: (value) {
                setState(() {
                  _palatability = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            SizedBox(
              height: 120.h,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 18.h),
              child: SaveButton(
                onPressed: _isAllInserted()
                    ? () async {
                        // 데이터 저장
                        saveMeatData();

                        // 데이터 서버로 전송
                        await ApiServices.sendMeatData('heatedmeat_eval', widget.meatData.convertHeatedMeatToJson());

                        if (!mounted) return;
                        FocusScope.of(context).unfocus();
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
