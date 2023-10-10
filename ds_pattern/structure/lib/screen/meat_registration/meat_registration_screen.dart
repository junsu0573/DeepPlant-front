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
        child: Column(
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
                isCompleted:
                    widget.meatModel.secondaryValue != null ? true : false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            // STEP 2
            InkWell(
              onTap: () => widget.meatModel.secondaryValue != null
                  ? context
                      .read<MeatRegistrationViewModel>()
                      .clickedImage(context)
                  : null,
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: widget.meatModel.secondaryValue != null
                    ? '육류 단면을 촬영해 주세요.'
                    : '육류 기본정보 입력 후 진행해주세요.',
                step: '2',
                isCompleted: widget.meatModel.imagePath != null ? true : false,
                isBefore: widget.meatModel.secondaryValue == null,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            // STEP 3
            InkWell(
              onTap: () => widget.meatModel.imagePath != null
                  ? context
                      .read<MeatRegistrationViewModel>()
                      .clickedFreshmeat(context)
                  : null,
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: widget.meatModel.imagePath != null
                    ? '육류 관능평가를 진행해 주세요.'
                    : '육류 단면 촬영 완료 후 진행해주세요.',
                step: '3',
                isCompleted: widget.meatModel.freshmeat != null ? true : false,
                isBefore: widget.meatModel.imagePath == null,
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButton(
                    onPressed: () {},
                    text: '임시저장',
                    width: 310.w,
                    heigh: 104.h,
                    isWhite: true,
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  MainButton(
                    onPressed: widget.meatModel.secondaryValue != null &&
                            widget.meatModel.imagePath != null &&
                            widget.meatModel.freshmeat != null
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
