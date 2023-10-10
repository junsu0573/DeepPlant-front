import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/part_eval.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/meat_registration/freshmeat_eval_view_model.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  List<List<String>> text = [
    ['Mabling', '마블링 정도', '없음', '', '보통', '', '많음'],
    ['Color', '육색', '없음', '', '보통', '', '어둡고 진함'],
    ['Texture', '조직감', '흐물함', '', '보통', '', '단단함'],
    ['Surface Moisture', '표면육즙', '없음', '', '보통', '', '많음'],
    ['Overall', '종합기호도', '나쁨', '', '보통', '', '좋음'],
  ];

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
                context.watch<FreshMeatEvalViewModel>().title,
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 46.h),
              SizedBox(
                width: 600.w,
                height: 600.h,
                child: context
                        .read<FreshMeatEvalViewModel>()
                        .meatImage
                        .contains('http')
                    ? Image.network(
                        context.read<FreshMeatEvalViewModel>().meatImage,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.error);
                        },
                      )
                    : Image.file(
                        File(context.read<FreshMeatEvalViewModel>().meatImage),
                        fit: BoxFit.cover,
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
                  onPressed: context.watch<FreshMeatEvalViewModel>().completed
                      ? () async => context
                          .read<FreshMeatEvalViewModel>()
                          .saveMeatData(context)
                      : null,
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
