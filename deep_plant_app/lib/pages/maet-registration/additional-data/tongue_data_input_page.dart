import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/textfield_with_title.dart';

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
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '전자혀 데이터',
                    textAlign: TextAlign.center,
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
                  TextFieldWithTitle(
                      firstText: 'Sourness',
                      secondText: '신맛',
                      controller: sourness),
                  TextFieldWithTitle(
                      firstText: 'Bitterness',
                      secondText: '진한맛',
                      controller: bitterness),
                  TextFieldWithTitle(
                      firstText: 'Umami', secondText: '감칠맛', controller: umami),
                  TextFieldWithTitle(
                      firstText: 'Richness',
                      secondText: '후미',
                      controller: richness),
                ],
              ),
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
    );
  }
}
