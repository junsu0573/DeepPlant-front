import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/part_eval.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/freshmeat_eval_view_model.dart';

class FreshMeatEvalScreen extends StatefulWidget {
  const FreshMeatEvalScreen({
    super.key,
  });

  @override
  State<FreshMeatEvalScreen> createState() => _FreshMeatEvalScreenState();
}

class _FreshMeatEvalScreenState extends State<FreshMeatEvalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String _meatImage = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // if (widget.isDeepAged != null &&
    //     widget.isDeepAged == true &&
    //     widget.meatData.deepAgedImage != null) {
    //   _meatImage = widget.meatData.deepAgedImage!;
    // } else if (widget.meatData.imagePath != null) {
    //   _meatImage = widget.meatData.imagePath!;
    // }
    // initialize();
    // setState(() {});
  }

  List<List<String>> text = [
    ['Mabling', '마블링 정도', '없음', '', '보통', '', '많음'],
    ['Color', '육색', '없음', '', '보통', '', '어둡고 진함'],
    ['Texture', '조직감', '흐물함', '', '보통', '', '단단함'],
    ['Surface Moisture', '표면육즙', '없음', '', '보통', '', '많음'],
    ['Overall', '종합기호도', '나쁨', '', '보통', '', '좋음'],
  ];

  // bool _isAllInserted() {
  //   if (_marbling! > 0 &&
  //       _color! > 0 &&
  //       _texture! > 0 &&
  //       _surface! > 0 &&
  //       _overall! > 0) return true;
  //   return false;
  // }

  // void initialize() {
  //   if (widget.meatData.deepAgedFreshmeat?['marbling'] != null &&
  //       widget.isDeepAged == true) {
  //     _marbling = widget.meatData.deepAgedFreshmeat?['marbling'];
  //     _color = widget.meatData.deepAgedFreshmeat?['color'];
  //     _texture = widget.meatData.deepAgedFreshmeat?['texture'];
  //     _surface = widget.meatData.deepAgedFreshmeat?['surfaceMoisture'];
  //     _overall = widget.meatData.deepAgedFreshmeat?['overall'];
  //   } else if (widget.meatData.freshmeat?['marbling'] != null &&
  //       widget.isDeepAged == null) {
  //     _marbling = widget.meatData.freshmeat?['marbling'];
  //     _color = widget.meatData.freshmeat?['color'];
  //     _texture = widget.meatData.freshmeat?['texture'];
  //     _surface = widget.meatData.freshmeat?['surfaceMoisture'];
  //     _overall = widget.meatData.freshmeat?['overall'];
  //   }
  // }

  // void saveMeatData() {
  //   //데이터를 Map 형식으로 저장
  //   Map<String, dynamic> freshData = {
  //     'createdAt': GetDate.getCurrentDate(),
  //     'period': widget.meatData.getPeriod(),
  //     'marbling': _marbling,
  //     'color': _color,
  //     'texture': _texture,
  //     'surfaceMoisture': _surface,
  //     'overall': _overall,
  //   };

  //   // 데이터를 객체에 저장
  //   if (widget.isDeepAged != null) {
  //     widget.meatData.deepAgedFreshmeat = freshData;
  //   } else {
  //     widget.meatData.freshmeat = freshData;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '신선육관능평가',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 46.h),
              Container(
                width: 600.w,
                height: 600.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(
                      File(_meatImage),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.w,
                  ),
                  Icon(
                    Icons.check,
                    color: context.watch<FreshMeatEvalViewModel>().marbling > 0
                        ? Palette.mainButtonColor
                        : Colors.transparent,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: context.watch<FreshMeatEvalViewModel>().color > 0
                        ? Palette.mainButtonColor
                        : Colors.transparent,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: context.watch<FreshMeatEvalViewModel>().texture > 0
                        ? Palette.mainButtonColor
                        : Colors.transparent,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: context.watch<FreshMeatEvalViewModel>().surface > 0
                        ? Palette.mainButtonColor
                        : Colors.transparent,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: context.watch<FreshMeatEvalViewModel>().overall > 0
                        ? Palette.mainButtonColor
                        : Colors.transparent,
                  ),
                  SizedBox(
                    width: 70.w,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                ),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        '마블링',
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '육색',
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '조직감',
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '육즙',
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '기호도',
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                  ],
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(120, 120, 120, 1),
                  ),
                  indicator: ShapeDecoration(
                    shape: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3.0.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 300.h,
                child: Consumer<FreshMeatEvalViewModel>(
                  builder: (context, viewModel, child) => TabBarView(
                    controller: _tabController,
                    children: [
                      // 마블링
                      Center(
                        child: PartEval(
                          selectedText: text[0],
                          value: viewModel.marbling,
                          onChanged: (value) =>
                              viewModel.onChangedMarbling(value),
                        ),
                      ),
                      // 육색
                      Center(
                        child: PartEval(
                          selectedText: text[1],
                          value: viewModel.color,
                          onChanged: (value) => viewModel.onChangedColor(value),
                        ),
                      ),
                      // 조직감
                      Center(
                        child: PartEval(
                          selectedText: text[2],
                          value: viewModel.texture,
                          onChanged: (value) =>
                              viewModel.onChangedTexture(value),
                        ),
                      ),
                      // 육즙
                      Center(
                        child: PartEval(
                          selectedText: text[3],
                          value: viewModel.surface,
                          onChanged: (value) =>
                              viewModel.onChangedSurface(value),
                        ),
                      ),
                      // 기호도
                      Center(
                        child: PartEval(
                          selectedText: text[4],
                          value: viewModel.overall,
                          onChanged: (value) =>
                              viewModel.onChangedOverall(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 18.h),
                child: MainButton(
                  onPressed: context.read<FreshMeatEvalViewModel>().completed
                      ? () {
                          print('here');
                        }
                      : null,
                  //     ? () async {
                  //         // 데이터 저장
                  //         saveMeatData();
                  //         if (widget.isDeepAged != null &&
                  //             widget.isDeepAged == true) {
                  //           // 서버로 전송
                  //           await ApiServices.sendMeatData('sensory_eval',
                  //               widget.meatData.convertFreshMeatToJson(1));
                  //         }
                  //         if (!mounted) return;
                  //         Navigator.pop(context);
                  //       }
                  //     : null,
                  text: '저장',
                  width: 658.w,
                  heigh: 104.h,
                  isWhite: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
