import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/heated_meat_evaluation_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/lab_data_input_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/tongue_data_input_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/fresh_meat_evaluation_page.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/insertion_meat_image.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StepDeepagingMeat extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  const StepDeepagingMeat({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<StepDeepagingMeat> createState() => _StepDeepagingMeatState();
}

class _StepDeepagingMeatState extends State<StepDeepagingMeat> {
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
                    imageIdx: 2,
                  ),
                ),
              ).then((value) {
                setState(() {});
              }),
              child: StepCard(
                mainText: '처리육 단면 촬영',
                subText: '데이터를 입력해주세요',
                step: '1',
                isCompleted:
                    widget.meatData.deepAgedImage != null ? true : false,
              ),
            ),
            InkWell(
              onTap: () => widget.meatData.deepAgedImage != null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FreshMeatEvaluation(
                          meatData: widget.meatData,
                          isDeepAged: true,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    })
                  : null,
              child: StepCard(
                mainText: '처리육 관능평가',
                subText: widget.meatData.deepAgedImage != null
                    ? '데이터를 입력해주세요'
                    : '처리육 단면 촬영을 완료해주세요',
                step: '2',
                isCompleted: widget.meatData.deepAgedFreshmeat != null &&
                        widget.meatData.deepAgedFreshmeat!['marbling'] != null
                    ? true
                    : false,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeatedMeatEvaluation(
                    meatData: widget.meatData,
                  ),
                ),
              ).then((value) {
                setState(() {});
              }),
              child: StepCard(
                mainText: '가열육 관능평가',
                subText: '데이터를 입력해주세요',
                step: '3',
                isCompleted: widget.meatData.heatedmeat != null ? true : false,
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TongueDataInputPage(meatData: widget.meatData),
                ),
              ).then((value) {
                setState(() {});
              }),
              child: StepCard(
                mainText: '전자혀 데이터',
                subText: '데이터를 입력해주세요',
                step: '4',
                isCompleted: widget.meatData.tongueData != null &&
                        !widget.meatData.tongueData!.containsValue(null)
                    ? true
                    : false,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LabDataInput(
                    meatData: widget.meatData,
                  ),
                ),
              ).then((value) {
                setState(() {});
              }),
              child: StepCard(
                mainText: '실험 데이터',
                subText: '데이터를 입력해주세요',
                step: '5',
                isCompleted: widget.meatData.labData != null &&
                        !widget.meatData.labData!.containsValue(null)
                    ? true
                    : false,
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
                      context.pop();
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
