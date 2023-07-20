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

  void saveMeatData() {
    final lData = double.parse(l.text);
    final aData = double.parse(a.text);
    final bData = double.parse(b.text);
    final dlData = double.parse(dl.text);
    final clData = double.parse(cl.text);
    final rwData = double.parse(rw.text);
    final phData = double.parse(ph.text);
    final wbsfData = double.parse(wbsf.text);
    final ctData = double.parse(ct.text);
    final mfiData = double.parse(mfi.text);

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

  bool _isAllInserted() {
    if (l.text.isNotEmpty &&
        a.text.isNotEmpty &&
        b.text.isNotEmpty &&
        dl.text.isNotEmpty &&
        cl.text.isNotEmpty &&
        rw.text.isNotEmpty &&
        ph.text.isNotEmpty &&
        wbsf.text.isNotEmpty &&
        ct.text.isNotEmpty &&
        mfi.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    if (widget.meatData.labData != null) {
      l.text = widget.meatData.labData!['L'].toString();
      a.text = widget.meatData.labData!['a'].toString();
      b.text = widget.meatData.labData!['b'].toString();
      dl.text = widget.meatData.labData!['DL'].toString();
      cl.text = widget.meatData.labData!['CL'].toString();
      rw.text = widget.meatData.labData!['RW'].toString();
      ph.text = widget.meatData.labData!['ph'].toString();
      wbsf.text = widget.meatData.labData!['WBSF'].toString();
      ct.text = widget.meatData.labData!['cardepsin_activity'].toString();
      mfi.text = widget.meatData.labData!['MFI'].toString();
    }
    super.initState();
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
              TextFieldWithTitle(firstText: 'L명도', secondText: '', controller: l),
              TextFieldWithTitle(firstText: 'a적색도', secondText: '', unit: '', controller: a),
              TextFieldWithTitle(firstText: 'b황색도', secondText: '', unit: '', controller: b),
              TextFieldWithTitle(firstText: 'DL육즙감량', secondText: '', unit: '%', controller: dl),
              TextFieldWithTitle(firstText: 'CL가열감량', secondText: '', unit: '%', controller: cl),
              TextFieldWithTitle(firstText: 'RW압착감량', secondText: '', unit: '%', controller: rw),
              TextFieldWithTitle(firstText: 'PH', secondText: '', controller: ph),
              TextFieldWithTitle(firstText: 'WBSF전단가', secondText: '', unit: 'kgf', controller: wbsf),
              TextFieldWithTitle(firstText: '카텝신활성도', secondText: '', controller: ct),
              TextFieldWithTitle(firstText: 'MFI근소편화지수', secondText: '', controller: mfi),
              SizedBox(
                height: 16.h,
              ),
              SaveButton(
                onPressed: _isAllInserted()
                    ? () {
                        // 데이터 저장
                        saveMeatData();

                        // 데이터 서버로 전송
                        ApiServices.sendMeatData('probexp_data', widget.meatData.convertPorbexptToJson());

                        if (!mounted) return;
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
