import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/labdata_field.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/viewModel/data_management/insertion_lab_data_view_model.dart';

class InsertionLabDataScreen extends StatefulWidget {
  const InsertionLabDataScreen({super.key});

  @override
  State<InsertionLabDataScreen> createState() => _InsertionLabDataScreenState();
}

class _InsertionLabDataScreenState extends State<InsertionLabDataScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.meatData.labData != null) {
  //     if (widget.meatData.labData!['L'] != null) {
  //       l.text = widget.meatData.labData!['L'].toString();
  //     }
  //     if (widget.meatData.labData!['a'] != null) {
  //       a.text = widget.meatData.labData!['a'].toString();
  //     }
  //     if (widget.meatData.labData!['b'] != null) {
  //       b.text = widget.meatData.labData!['b'].toString();
  //     }
  //     if (widget.meatData.labData!['DL'] != null) {
  //       dl.text = widget.meatData.labData!['DL'].toString();
  //     }
  //     if (widget.meatData.labData!['CL'] != null) {
  //       cl.text = widget.meatData.labData!['CL'].toString();
  //     }
  //     if (widget.meatData.labData!['RW'] != null) {
  //       rw.text = widget.meatData.labData!['RW'].toString();
  //     }
  //     if (widget.meatData.labData!['ph'] != null) {
  //       ph.text = widget.meatData.labData!['ph'].toString();
  //     }
  //     if (widget.meatData.labData!['WBSF'] != null) {
  //       wbsf.text = widget.meatData.labData!['WBSF'].toString();
  //     }
  //     if (widget.meatData.labData!['cardepsin_activity'] != null) {
  //       ct.text = widget.meatData.labData!['cardepsin_activity'].toString();
  //     }
  //     if (widget.meatData.labData!['MFI'] != null) {
  //       mfi.text = widget.meatData.labData!['MFI'].toString();
  //     }
  //     if (widget.meatData.labData!['Collagen'] != null) {
  //       collagen.text = widget.meatData.labData!['Collagen'].toString();
  //     }
  //   }
  // }

  // void saveMeatData() {
  //   final double? lData;
  //   final double? aData;
  //   final double? bData;
  //   final double? dlData;
  //   final double? clData;
  //   final double? rwData;
  //   final double? phData;
  //   final double? wbsfData;
  //   final double? ctData;
  //   final double? mfiData;
  //   final double? collagenData;

  //   if (l.text.isNotEmpty) {
  //     lData = double.parse(l.text);
  //   } else {
  //     lData = null;
  //   }
  //   if (a.text.isNotEmpty) {
  //     aData = double.parse(a.text);
  //   } else {
  //     aData = null;
  //   }
  //   if (b.text.isNotEmpty) {
  //     bData = double.parse(b.text);
  //   } else {
  //     bData = null;
  //   }
  //   if (dl.text.isNotEmpty) {
  //     dlData = double.parse(dl.text);
  //   } else {
  //     dlData = null;
  //   }
  //   if (cl.text.isNotEmpty) {
  //     clData = double.parse(cl.text);
  //   } else {
  //     clData = null;
  //   }
  //   if (rw.text.isNotEmpty) {
  //     rwData = double.parse(rw.text);
  //   } else {
  //     rwData = null;
  //   }
  //   if (ph.text.isNotEmpty) {
  //     phData = double.parse(ph.text);
  //   } else {
  //     phData = null;
  //   }
  //   if (wbsf.text.isNotEmpty) {
  //     wbsfData = double.parse(wbsf.text);
  //   } else {
  //     wbsfData = null;
  //   }
  //   if (ct.text.isNotEmpty) {
  //     ctData = double.parse(ct.text);
  //   } else {
  //     ctData = null;
  //   }
  //   if (mfi.text.isNotEmpty) {
  //     mfiData = double.parse(mfi.text);
  //   } else {
  //     mfiData = null;
  //   }
  //   if (collagen.text.isNotEmpty) {
  //     collagenData = double.parse(collagen.text);
  //   } else {
  //     collagenData = null;
  //   }

  //   // 데이터 생성
  //   Map<String, dynamic> labData = {
  //     'L': lData,
  //     'a': aData,
  //     'b': bData,
  //     'DL': dlData,
  //     'CL': clData,
  //     'RW': rwData,
  //     'ph': phData,
  //     'WBSF': wbsfData,
  //     'cardepsin_activity': ctData,
  //     'MFI': mfiData,
  //     'Collagen': collagenData
  //   };

  //   // 데이터를 객체에 저장
  //   widget.meatData.labData = labData;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 unfocus
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: '추가정보 입력',
          backButton: false,
          closeButton: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '실험데이터',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontSize: 36.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  LabDataField(
                      firstText: 'L',
                      secondText: '명도',
                      controller: context.read<InsertionLabDataViewModel>().l),
                  LabDataField(
                      firstText: 'a',
                      secondText: '적색도',
                      unit: '',
                      controller: context.read<InsertionLabDataViewModel>().a),
                  LabDataField(
                      firstText: 'b',
                      secondText: '황색도',
                      unit: '',
                      controller: context.read<InsertionLabDataViewModel>().b),
                  LabDataField(
                      firstText: 'DL',
                      secondText: '육즙감량',
                      unit: '%',
                      controller: context.read<InsertionLabDataViewModel>().dl,
                      isPercent: true),
                  LabDataField(
                      firstText: 'CL',
                      secondText: '가열감량',
                      unit: '%',
                      controller: context.read<InsertionLabDataViewModel>().cl,
                      isPercent: true),
                  LabDataField(
                      firstText: 'RW',
                      secondText: '압착감량',
                      unit: '%',
                      controller: context.read<InsertionLabDataViewModel>().rw,
                      isPercent: true),
                  LabDataField(
                      firstText: 'pH',
                      secondText: '산도',
                      controller: context.read<InsertionLabDataViewModel>().ph),
                  LabDataField(
                      firstText: 'WBSF',
                      secondText: '전단가',
                      unit: 'kgf',
                      controller:
                          context.read<InsertionLabDataViewModel>().wbsf),
                  LabDataField(
                      firstText: '카텝신활성도',
                      secondText: '',
                      controller: context.read<InsertionLabDataViewModel>().ct),
                  LabDataField(
                      firstText: 'MFI',
                      secondText: '근소편화지수',
                      controller:
                          context.read<InsertionLabDataViewModel>().mfi),
                  LabDataField(
                      firstText: 'Collagen',
                      secondText: '콜라겐',
                      controller:
                          context.read<InsertionLabDataViewModel>().collagen),
                  SizedBox(
                    height: 16.h,
                  ),
                  MainButton(
                    onPressed: () async => context
                        .read<InsertionLabDataViewModel>()
                        .saveData(context),
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
              context.watch<InsertionLabDataViewModel>().isLoading
                  ? const CircularProgressIndicator()
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
