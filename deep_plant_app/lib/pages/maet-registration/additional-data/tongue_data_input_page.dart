import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/tongue_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/save_button.dart';

class TongueDataInputPage extends StatefulWidget {
  final MeatData meatData;
  const TongueDataInputPage({
    super.key,
    required this.meatData,
  });

  @override
  State<TongueDataInputPage> createState() => _TongueDataInputPageState();
}

class _TongueDataInputPageState extends State<TongueDataInputPage> {
  TextEditingController sourness = TextEditingController();
  TextEditingController bitterness = TextEditingController();
  TextEditingController umami = TextEditingController();
  TextEditingController richness = TextEditingController();
  void _sendEvaluation() async {
    final sournessData = double.parse(sourness.text);
    final bitternessData = double.parse(bitterness.text);
    final umamiData = double.parse(umami.text);
    final richnessData = double.parse(richness.text);

    Map<String, double> tongueData = {
      //데이터를 Map 형식으로 지정
      'sourness': sournessData,
      'bitterness': bitternessData,
      'umami': umamiData,
      'richness': richnessData,
    };

    // 데이터를 객체에 저장
    widget.meatData.tongueData = tongueData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '추가정보 입력',
        backButton: true,
        closeButton: true,
        backButtonOnPressed: () {
          showExitDialog(context, null);
        },
        closeButtonOnPressed: () {
          showExitDialog(context, null); // CustomDialog
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 unfocus
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 38.h,
              ),
              Text(
                '전자혀 데이터',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 36.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              TongueFiled(mainText: 'Sourness', subText: '신맛'),
              SizedBox(
                height: 112.h,
              ),
              TongueFiled(mainText: 'Bitterness', subText: '진한맛'),
              SizedBox(
                height: 112.h,
              ),
              TongueFiled(mainText: 'Umami', subText: '감칠맛'),
              SizedBox(
                height: 112.h,
              ),
              TongueFiled(mainText: 'Richness', subText: '후미'),
              SizedBox(
                height: 260.h,
              ),
              SaveButton(
                onPressed: _sendEvaluation,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                isWhite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
