import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/textfield_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperimentDataInputPage extends StatefulWidget {
  const ExperimentDataInputPage({super.key});

  @override
  State<ExperimentDataInputPage> createState() =>
      _ExperimentDataInputPageState();
}

class _ExperimentDataInputPageState extends State<ExperimentDataInputPage> {
  TextEditingController DL = TextEditingController();
  TextEditingController CL = TextEditingController();
  TextEditingController PH = TextEditingController();
  TextEditingController WBSF = TextEditingController();
  TextEditingController CT = TextEditingController();
  TextEditingController MFI = TextEditingController();
  void _sendEvaluation() async {
    final DLdata = DL.text;
    final CLdata = CL.text;
    final PHdata = PH.text;
    final WBSFdata = WBSF.text;
    final CTdata = CT.text;
    final MFIdata = MFI.text;

    //경로 수정
    //firebase 전송
    await FirebaseFirestore.instance.collection('evaluations').doc().set({
      'DL': DLdata,
      'CL': CLdata,
      'PH': PHdata,
      'WBSF': WBSFdata,
      'CT': CTdata,
      'MFI': MFIdata
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: '추가정보 입력', backButton: true, closeButton: true),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 unfocus
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '실험데이터',
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
                  firstText: 'DL육즙감량',
                  secondText: '',
                  unit: '%',
                  controller: DL),
              TextFieldWithTitle(
                  firstText: 'CL가열감량',
                  secondText: '',
                  unit: '%',
                  controller: CL),
              TextFieldWithTitle(
                  firstText: 'PH', secondText: '', controller: PH),
              TextFieldWithTitle(
                  firstText: 'WBSF전단가',
                  secondText: '',
                  unit: 'kgf',
                  controller: WBSF),
              TextFieldWithTitle(
                  firstText: '카텝신활성도', secondText: '', controller: CT),
              TextFieldWithTitle(
                  firstText: 'MFI근소편화지수', secondText: '', controller: MFI),
              SizedBox(
                height: 16.h,
              ),
              SaveButton(
                onPressed: _sendEvaluation,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
