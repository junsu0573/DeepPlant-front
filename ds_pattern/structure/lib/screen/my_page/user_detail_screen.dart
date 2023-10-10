import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/round_button.dart';
import 'package:structure/viewModel/my_page/user_detail_view_model.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
          title: '아이디/비밀번호', backButton: true, closeButton: false),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '아이디',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 658.w,
                          height: 85.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 32.w),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(232, 232, 232, 1),
                            borderRadius: BorderRadius.circular(42.sp),
                          ),
                          child: Text(
                            context.read<UserDetailViewModel>().userId,
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(153, 153, 153, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        Text(
                          '비밀번호',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // 비밀번호 변경 버튼
                        RoundButton(
                          text: const Text('비밀번호 변경하기'),
                          onPress: () => context
                              .read<UserDetailViewModel>()
                              .clickedChangePW(context),
                          width: 658.w,
                          height: 85.h,
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        Row(
                          children: [
                            Text(
                              '주소',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => context
                                  .read<UserDetailViewModel>()
                                  .clickedEditButton(),
                              child: Text(
                                context.watch<UserDetailViewModel>().isEditting
                                    ? '완료'
                                    : '수정',
                                style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 412.w,
                              child: TextField(
                                onChanged: (value) => context
                                    .read<UserDetailViewModel>()
                                    .onChangedMainAdress(value),
                                controller: context
                                    .read<UserDetailViewModel>()
                                    .mainAddress,
                                enabled: context
                                    .watch<UserDetailViewModel>()
                                    .isEditting,
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
                              onPress: context
                                      .watch<UserDetailViewModel>()
                                      .isEditting
                                  ? () async {
                                      await context
                                          .read<UserDetailViewModel>()
                                          .clickedSearchButton(context);
                                    }
                                  : null,
                              width: 125.w,
                              height: 75.h,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        SizedBox(
                          child: TextField(
                            enabled:
                                context.watch<UserDetailViewModel>().isEditting,
                            controller:
                                context.read<UserDetailViewModel>().subAddress,
                            decoration: const InputDecoration(
                              hintText: '상세주소 (동/호수)',
                            ),
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
                          controller:
                              context.read<UserDetailViewModel>().company,
                          enabled:
                              context.watch<UserDetailViewModel>().isEditting,
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
                              width: 235.w,
                              child: TextField(
                                enabled: context
                                    .watch<UserDetailViewModel>()
                                    .isEditting,
                                controller: context
                                    .read<UserDetailViewModel>()
                                    .department,
                                decoration: const InputDecoration(
                                  hintText: '부서명',
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 235.w,
                              child: TextField(
                                enabled: context
                                    .watch<UserDetailViewModel>()
                                    .isEditting,
                                controller: context
                                    .read<UserDetailViewModel>()
                                    .jobTitle,
                                decoration: const InputDecoration(
                                  hintText: '직위',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 81.h,
                        ),
                      ],
                    ),
                  ),
                  MainButton(
                    onPressed: !context.watch<UserDetailViewModel>().isEditting
                        ? () async {
                            await context
                                .read<UserDetailViewModel>()
                                .clickedSaveButton();
                          }
                        : null,
                    text: '저장',
                    width: 658.w,
                    heigh: 106.h,
                    isWhite: false,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                ],
              ),
            ),
          ),
          context.watch<UserDetailViewModel>().isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
