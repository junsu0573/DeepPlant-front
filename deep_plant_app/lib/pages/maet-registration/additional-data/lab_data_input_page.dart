import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/textfield_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LabDataInput extends StatefulWidget {
  final MeatData meatData;
  const LabDataInput({
    super.key,
    required this.meatData,
  });

  @override
  State<LabDataInput> createState() => _LabDataInputState();
}

class _LabDataInputState extends State<LabDataInput> {
  TextEditingController l = TextEditingController();
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController dl = TextEditingController();
  TextEditingController cl = TextEditingController();
  TextEditingController rw = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController wbsf = TextEditingController();
  TextEditingController ct = TextEditingController();
  TextEditingController mfi = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.meatData.labData != null) {
      if (widget.meatData.labData!['L'] != null) {
        l.text = widget.meatData.labData!['L'].toString();
      }
      if (widget.meatData.labData!['a'] != null) {
        a.text = widget.meatData.labData!['a'].toString();
      }
      if (widget.meatData.labData!['b'] != null) {
        b.text = widget.meatData.labData!['b'].toString();
      }
      if (widget.meatData.labData!['DL'] != null) {
        dl.text = widget.meatData.labData!['DL'].toString();
      }
      if (widget.meatData.labData!['CL'] != null) {
        cl.text = widget.meatData.labData!['CL'].toString();
      }
      if (widget.meatData.labData!['RW'] != null) {
        rw.text = widget.meatData.labData!['RW'].toString();
      }
      if (widget.meatData.labData!['ph'] != null) {
        ph.text = widget.meatData.labData!['ph'].toString();
      }
      if (widget.meatData.labData!['WBSF'] != null) {
        wbsf.text = widget.meatData.labData!['WBSF'].toString();
      }
      if (widget.meatData.labData!['cardepsin_activity'] != null) {
        ct.text = widget.meatData.labData!['cardepsin_activity'].toString();
      }
      if (widget.meatData.labData!['MFI'] != null) {
        mfi.text = widget.meatData.labData!['MFI'].toString();
      }
    }
  }

  void saveMeatData() {
    final double? lData;
    final double? aData;
    final double? bData;
    final double? dlData;
    final double? clData;
    final double? rwData;
    final double? phData;
    final double? wbsfData;
    final double? ctData;
    final double? mfiData;
    if (l.text.isNotEmpty) {
      lData = double.parse(l.text);
    } else {
      lData = null;
    }
    if (a.text.isNotEmpty) {
      aData = double.parse(a.text);
    } else {
      aData = null;
    }
    if (b.text.isNotEmpty) {
      bData = double.parse(b.text);
    } else {
      bData = null;
    }
    if (dl.text.isNotEmpty) {
      dlData = double.parse(dl.text);
    } else {
      dlData = null;
    }
    if (cl.text.isNotEmpty) {
      clData = double.parse(cl.text);
    } else {
      clData = null;
    }
    if (rw.text.isNotEmpty) {
      rwData = double.parse(rw.text);
    } else {
      rwData = null;
    }
    if (ph.text.isNotEmpty) {
      phData = double.parse(ph.text);
    } else {
      phData = null;
    }
    if (wbsf.text.isNotEmpty) {
      wbsfData = double.parse(wbsf.text);
    } else {
      wbsfData = null;
    }
    if (ct.text.isNotEmpty) {
      ctData = double.parse(ct.text);
    } else {
      ctData = null;
    }
    if (mfi.text.isNotEmpty) {
      mfiData = double.parse(mfi.text);
    } else {
      mfiData = null;
    }

    // 데이터 생성
    Map<String, dynamic> labData = {
      'L': lData,
      'a': aData,
      'b': bData,
      'DL': dlData,
      'CL': clData,
      'RW': rwData,
      'ph': phData,
      'WBSF': wbsfData,
      'cardepsin_activity': ctData,
      'MFI': mfiData
    };

    // 데이터를 객체에 저장
    widget.meatData.labData = labData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 unfocus
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: '추가정보 입력',
          backButton: false,
          closeButton: true,
          closeButtonOnPressed: () {
            showExitDialog(context, null);
          },
        ),
        body: SingleChildScrollView(
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
                  firstText: 'L명도', secondText: '', controller: l),
              TextFieldWithTitle(
                  firstText: 'a적색도', secondText: '', unit: '', controller: a),
              TextFieldWithTitle(
                  firstText: 'b황색도', secondText: '', unit: '', controller: b),
              TextFieldWithTitle(
                firstText: 'DL육즙감량',
                secondText: '',
                unit: '%',
                controller: dl,
                isPercent: true,
              ),
              TextFieldWithTitle(
                firstText: 'CL가열감량',
                secondText: '',
                unit: '%',
                controller: cl,
                isPercent: true,
              ),
              TextFieldWithTitle(
                firstText: 'RW압착감량',
                secondText: '',
                unit: '%',
                controller: rw,
                isPercent: true,
              ),
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
                onPressed: () {
                  // 데이터 저장
                  saveMeatData();

                  // 데이터 서버로 전송
                  ApiServices.sendMeatData(
                      'probexpt_data', widget.meatData.convertPorbexptToJson());

                  if (!mounted) return;
                  context.pop();
                },
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
