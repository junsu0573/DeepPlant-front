import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/tongue_field.dart';
import 'package:structure/viewModel/data_management/insertion_tongue_data_view_model.dart';

class InsertionTongueDataScreen extends StatefulWidget {
  const InsertionTongueDataScreen({super.key});

  @override
  State<InsertionTongueDataScreen> createState() =>
      _InsertionTongueDataScreenState();
}

class _InsertionTongueDataScreenState extends State<InsertionTongueDataScreen> {
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
                children: [
                  SizedBox(
                    height: 38.h,
                  ),
                  Text(
                    '전자혀 데이터',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  TongueFiled(
                    mainText: 'Sourness',
                    subText: '신맛',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().sourness,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Bitterness',
                    subText: '진한맛',
                    controller: context
                        .watch<InsertionTongueDataViewModel>()
                        .bitterness,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Umami',
                    subText: '감칠맛',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().umami,
                  ),
                  SizedBox(
                    height: 112.h,
                  ),
                  TongueFiled(
                    mainText: 'Richness',
                    subText: '후미',
                    controller:
                        context.watch<InsertionTongueDataViewModel>().richness,
                  ),
                  SizedBox(
                    height: 300.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 28.h),
                    child: MainButton(
                      onPressed: () async => context
                          .read<InsertionTongueDataViewModel>()
                          .saveData(context),
                      text: '저장',
                      width: 658.w,
                      heigh: 104.h,
                      isWhite: false,
                    ),
                  ),
                ],
              ),
              context.watch<InsertionTongueDataViewModel>().isLoading
                  ? const CircularProgressIndicator()
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
