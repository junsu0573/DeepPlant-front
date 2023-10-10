import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/meat_registration/creation_management_num_view_model.dart.dart';

class CreationManagementNumScreen extends StatelessWidget {
  const CreationManagementNumScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: context.watch<CreationManagementNumViewModel>().isLoading
            ? const Text('관리번호 생성중')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Icon(
                    Icons.check_circle_outline,
                    size: 50,
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  const Text(
                    '관리번호',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    context
                        .read<CreationManagementNumViewModel>()
                        .managementNum,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '모든 등록이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '데이터를 서버로 전송했습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
                            color: Palette.subButtonColor,
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
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: MainButton(
                      onPressed: () => context
                          .read<CreationManagementNumViewModel>()
                          .clickedHomeButton(context),
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
