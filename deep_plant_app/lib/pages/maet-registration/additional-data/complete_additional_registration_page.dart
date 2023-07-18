import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CompleteAdditionalRegistration extends StatefulWidget {
  final MeatData meatData;
  const CompleteAdditionalRegistration({
    super.key,
    required this.meatData,
  });

  @override
  State<CompleteAdditionalRegistration> createState() =>
      _CompleteAdditionalRegistrationState();
}

class _CompleteAdditionalRegistrationState
    extends State<CompleteAdditionalRegistration> {
  bool isLoading = false;

  @override
  void initState() async {
    super.initState();
    setState(() {
      isLoading = true;
    });

    await sendMeatData(widget.meatData);

    setState(() {
      isLoading = false;
    });
  }

  // 육류 정보를 서버로 전송
  Future<void> sendMeatData(MeatData meatData) async {
    // 육류 정보를 json 형식으로 변환
    final deepAgingData = meatData.convertDeepAgingToJson();
    final freshMeatData = meatData.convertNewMeatToJson();
    final heatedMeatData = meatData.convertNewMeatToJson();
    final probexptData = meatData.convertPorbexptToJson();

    // 데이터 전송
    await ApiServices.sendMeatData(deepAgingData);
    await ApiServices.sendMeatData(freshMeatData);
    await ApiServices.sendMeatData(heatedMeatData);
    await ApiServices.sendMeatData(probexptData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? Text('데이터 등록중')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(
                    Icons.check_circle_outline,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '모든 등록이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '데이터를 서버로 전송했습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 119.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('인쇄');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 494.w,
                          height: 259.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Palette.lightOptionColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'QR코드 인쇄',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          left: 178.w,
                          child: Image.asset(
                            'assets/images/qr.png',
                            width: 137.w,
                            height: 137.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 28.h),
                    child: SaveButton(
                      onPressed: () => context.go('/option'),
                      text: '홈으로 이동',
                      width: 658.w,
                      heigh: 104.h,
                      isWhite: false,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
