import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/viewModel/sign_up/insertion_user_detail_view_model.dart';

class InsertionUserDetailScreen extends StatefulWidget {
  const InsertionUserDetailScreen({
    super.key,
  });

  @override
  State<InsertionUserDetailScreen> createState() =>
      _InsertionUserDetailScreenState();
}

class _InsertionUserDetailScreenState extends State<InsertionUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
            title: '상세정보', backButton: true, closeButton: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 62.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      '주소',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 412.w,
                          child: TextField(
                            controller: context
                                .read<InsertionUserDetailViewModel>()
                                .mainAddressController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: '주소',
                            ),
                          ),
                        ),
                        const Spacer(),
                        RoundButton(
                          text: Text(
                            '검색',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPress: () async => context
                              .read<InsertionUserDetailViewModel>()
                              .clickedSearchButton(context),
                          width: 125.w,
                          height: 75.h,
                          bgColor: const Color.fromRGBO(46, 48, 62, 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    TextField(
                      onChanged: (value) {
                        context
                            .read<InsertionUserDetailViewModel>()
                            .subHomeAdress = value;
                      },
                      enabled: context
                              .watch<InsertionUserDetailViewModel>()
                              .mainAddressController
                              .text
                              .isEmpty
                          ? false
                          : true,
                      decoration: const InputDecoration(
                        hintText: '상세주소 (동/호수)',
                      ),
                    ),
                    SizedBox(
                      height: 68.h,
                    ),
                    Text(
                      '회사정보',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    TextField(
                      onChanged: (value) {
                        context.read<InsertionUserDetailViewModel>().company =
                            value;
                      },
                      decoration: const InputDecoration(
                        hintText: '회사명',
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 240.w,
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<InsertionUserDetailViewModel>()
                                  .department = value;
                            },
                            decoration: const InputDecoration(
                              hintText: '부서명',
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 240.w,
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<InsertionUserDetailViewModel>()
                                  .jobTitle = value;
                            },
                            decoration: const InputDecoration(
                              hintText: '직위',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 330.h,
                    ),
                  ],
                ),
              ),
              MainButton(
                onPressed: () async => context
                    .read<InsertionUserDetailViewModel>()
                    .clickedNextButton(context),
                text: '다음',
                width: 658.w,
                heigh: 106.h,
                isWhite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
