import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/components/step_card.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/viewModel/meat_registration/meat_registration_view_model.dart';

class MeatRegistrationScreen extends StatefulWidget {
  final MeatModel meatModel;
  const MeatRegistrationScreen({
    super.key,
    required this.meatModel,
  });

  @override
  State<MeatRegistrationScreen> createState() => _MeatRegistrationScreenState();
}

class _MeatRegistrationScreenState extends State<MeatRegistrationScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MeatRegistrationViewModel>().initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backButton: true,
        closeButton: false,
      ),
      body: Center(
        child: context.watch<MeatRegistrationViewModel>().isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Text(
                    '육류 등록',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 105.h,
                  ),
                  // STEP 1
                  InkWell(
                    onTap: () => context
                        .read<MeatRegistrationViewModel>()
                        .clickedBasic(context),
                    child: StepCard(
                      mainText: '육류 기본정보 입력',
                      subText: '육류 정보를 입력해 주세요.',
                      step: '1',
                      isCompleted: widget.meatModel.basicCompleted,
                      isBefore: false,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  // STEP 2
                  InkWell(
                    onTap: () => widget.meatModel.basicCompleted
                        ? context
                            .read<MeatRegistrationViewModel>()
                            .clickedImage(context)
                        : null,
                    child: StepCard(
                      mainText: '육류 단면 촬영',
                      subText: widget.meatModel.basicCompleted
                          ? '육류 단면을 촬영해 주세요.'
                          : '육류 기본정보 입력 후 진행해주세요.',
                      step: '2',
                      isCompleted: widget.meatModel.freshImageCompleted,
                      isBefore: !widget.meatModel.basicCompleted,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  // STEP 3
                  InkWell(
                    onTap: () => widget.meatModel.freshImageCompleted
                        ? context
                            .read<MeatRegistrationViewModel>()
                            .clickedFreshmeat(context)
                        : null,
                    child: StepCard(
                      mainText: '신선육 관능평가',
                      subText: widget.meatModel.freshImageCompleted
                          ? '육류 관능평가를 진행해 주세요.'
                          : '육류 단면 촬영 완료 후 진행해주세요.',
                      step: '3',
                      isCompleted: widget.meatModel.rawFreshCompleted,
                      isBefore: !widget.meatModel.freshImageCompleted,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 28.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainButton(
                          onPressed: widget.meatModel.basicCompleted
                              ? () async => context
                                  .read<MeatRegistrationViewModel>()
                                  .clickedTempSaveButton(context)
                              : null,
                          text: '임시저장',
                          width: 310.w,
                          heigh: 104.h,
                          isWhite: true,
                        ),
                        SizedBox(
                          width: 32.w,
                        ),
                        MainButton(
                          onPressed: widget.meatModel.basicCompleted &&
                                  widget.meatModel.freshImageCompleted &&
                                  widget.meatModel.rawFreshCompleted
                              ? () => context
                                  .read<MeatRegistrationViewModel>()
                                  .clickedSaveButton(context)
                              : null,
                          text: '저장',
                          width: 310.w,
                          heigh: 104.h,
                          isWhite: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
