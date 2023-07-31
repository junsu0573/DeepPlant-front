import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/heated_meat_evaluation_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/lab_data_input_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/tongue_data_input_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/insertion_meat_image.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepFreshMeat extends StatefulWidget {
  final MeatData meatData;
  final UserData userData;
  const StepFreshMeat(
      {super.key, required this.meatData, required this.userData});

  @override
  State<StepFreshMeat> createState() => _StepFreshMeatState();
}

class _StepFreshMeatState extends State<StepFreshMeat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '추가정보 입력',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InsertionMeatImage(
                    meatData: widget.meatData,
                    userData: widget.userData,
                    imageIdx: 1,
                  ),
                ),
              ).then((_) {
                setState(() {});
              }),
              child: StepCard(
                mainText: '가열육 단면 촬영',
                subText: '육류 단면을 촬영해주세요',
                step: '1',
                isCompleted: widget.meatData.heatedImage != null ? true : false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: widget.meatData.heatedImage != null
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HeatedMeatEvaluation(
                                  meatData: widget.meatData,
                                )),
                      ).then((_) {
                        setState(() {});
                      })
                  : null,
              child: StepCard(
                mainText: '가열육 관능평가',
                subText: widget.meatData.heatedmeat != null
                    ? '육류 관능평가를 진행해 주세요'
                    : '육류 단면 촬영 완료 후 진행해주세요',
                step: '2',
                isCompleted: widget.meatData.heatedmeat != null &&
                        widget.meatData.heatedmeat!['flavor'] != null
                    ? true
                    : false,
                isBefore: widget.meatData.heatedImage == null,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: widget.meatData.heatedmeat != null
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TongueDataInputPage(
                                  meatData: widget.meatData,
                                )),
                      ).then((_) {
                        setState(() {});
                      })
                  : null,
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '전자혀 측정 데이터를 입력해주세요',
                step: '3',
                isCompleted: widget.meatData.tongueData != null &&
                        !widget.meatData.tongueData!.containsValue(null)
                    ? true
                    : false,
                isBefore: false,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            InkWell(
              onTap: widget.meatData.heatedmeat != null
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LabDataInput(
                                  meatData: widget.meatData,
                                )),
                      ).then((_) {
                        setState(() {});
                      })
                  : null,
              child: StepCard(
                mainText: '실험 데이터',
                subText: '실험 결과 데이터를 입력해주세요',
                step: '4',
                isCompleted: widget.meatData.labData != null &&
                        !widget.meatData.labData!.containsValue(null)
                    ? true
                    : false,
                isBefore: false,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SaveButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: '다음',
                    width: 620.w,
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
