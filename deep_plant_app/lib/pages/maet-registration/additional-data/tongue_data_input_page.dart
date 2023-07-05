import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/textfield_with_title.dart';

class TongueDataInputPage extends StatefulWidget {
  const TongueDataInputPage({super.key});

  @override
  State<TongueDataInputPage> createState() => _TongueDataInputPageState();
}

class _TongueDataInputPageState extends State<TongueDataInputPage> {
  TextEditingController Sourness = TextEditingController();
  TextEditingController Bitterness = TextEditingController();
  TextEditingController Umami = TextEditingController();
  TextEditingController Richness = TextEditingController();
  void _sendEvaluation() async {
    final Sournessdata = Sourness.text;
    final Bitternessdata = Bitterness.text;
    final Umamidata = Umami.text;
    final Richnessdata = Richness.text;

    //경로  수정
    //firebase 전송
    await FirebaseFirestore.instance.collection('evaluations').doc().set({
      'Sourness': Sournessdata,
      'Bitterness': Bitternessdata,
      'Umami': Umamidata,
      'Richness': Richnessdata,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
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
                      controller: Sourness),
                  TextFieldWithTitle(
                      firstText: 'Bitterness',
                      secondText: '진한맛',
                      controller: Bitterness),
                  TextFieldWithTitle(
                      firstText: 'Umami', secondText: '감칠맛', controller: Umami),
                  TextFieldWithTitle(
                      firstText: 'Richness',
                      secondText: '후미',
                      controller: Richness),
                  SizedBox(
                    height: 16.h,
                  ),
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
