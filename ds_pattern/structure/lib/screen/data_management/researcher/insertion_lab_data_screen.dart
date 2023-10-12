import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/labdata_field.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/viewModel/data_management/researcher/insertion_lab_data_view_model.dart';

class InsertionLabDataScreen extends StatefulWidget {
  const InsertionLabDataScreen({super.key});

  @override
  State<InsertionLabDataScreen> createState() => _InsertionLabDataScreenState();
}

class _InsertionLabDataScreenState extends State<InsertionLabDataScreen> {
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
