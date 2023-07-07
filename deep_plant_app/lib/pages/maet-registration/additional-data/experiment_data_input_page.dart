import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/textfield_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExperimentDataInputPage extends StatefulWidget {
  final MeatData meatData;
  const ExperimentDataInputPage({
    super.key,
    required this.meatData,
  });

  @override
  State<ExperimentDataInputPage> createState() =>
      _ExperimentDataInputPageState();
}

class _ExperimentDataInputPageState extends State<ExperimentDataInputPage> {
  TextEditingController dl = TextEditingController();
  TextEditingController cl = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController wbsf = TextEditingController();
  TextEditingController ct = TextEditingController();
  TextEditingController mfi = TextEditingController();

  void saveEvaluation() {
    final dldata = double.parse(dl.text);
    final cldata = double.parse(cl.text);
    final phdata = double.parse(ph.text);
    final wbsfdata = double.parse(wbsf.text);
    final ctdata = double.parse(ct.text);
    final mfidata = double.parse(mfi.text);

    Map<String, double> labData = {
      //데이터를 Map 형식으로 지정
      'DL': dldata,
      'CL': cldata,
      'ph': phdata,
      'WBSF': wbsfdata,
      'cardepsin_activity': ctdata,
      'MFI': mfidata
    };

    // 데이터를 객체에 저장
    widget.meatData.labData = labData;
  }

  bool _isAllInseted() {
    if (dl.text.isNotEmpty &&
        cl.text.isNotEmpty &&
        ph.text.isNotEmpty &&
        wbsf.text.isNotEmpty &&
        ct.text.isNotEmpty &&
        mfi.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '추가정보 입력',
        backButton: false,
        closeButton: true,
      ),
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
                  controller: dl),
              TextFieldWithTitle(
                  firstText: 'CL가열감량',
                  secondText: '',
                  unit: '%',
                  controller: cl),
              TextFieldWithTitle(
                  firstText: 'PH', secondText: '', controller: ph),
              TextFieldWithTitle(
                  firstText: 'WBSF전단가',
                  secondText: '',
                  unit: 'kgf',
                  controller: wbsf),
              TextFieldWithTitle(
                  firstText: '카텝신활성도', secondText: '', controller: ct),
              TextFieldWithTitle(
                  firstText: 'MFI근소편화지수', secondText: '', controller: mfi),
              SizedBox(
                height: 16.h,
              ),
              SaveButton(
                onPressed: _isAllInseted()
                    ? () {
                        saveEvaluation();
                        context.pop();
                      }
                    : null,
                text: '저장',
                width: 658.w,
                heigh: 104.h,
                isWhite: false,
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
