import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/get_date.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompleteResgistration2 extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;

  const CompleteResgistration2({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<CompleteResgistration2> createState() => _CompleteResgistration2State();
}

class _CompleteResgistration2State extends State<CompleteResgistration2> {
  String managementNum = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // 로딩상태 활성화
    setState(() {
      isLoading = true;
    });

    initialize();
  }

  Future<void> initialize() async {
    // 관리번호 생성
    createManagementNum();

    // 이미지 저장
    await sendImageToFirebase();

    // 데이터 전송
    await sendMeatData(widget.meatData);
  }

  // 관리번호 생성
  void createManagementNum() {
    if (widget.meatData.traceNum != null &&
        widget.meatData.speciesValue != null &&
        widget.meatData.primalValue != null &&
        widget.meatData.secondaryValue != null) {
      // 관리번호: 이력코드-생성일자-종-대분할-소분할
      String createdAt = GetDate.getCurrentDate();
      String originalString =
          '${widget.meatData.traceNum!}-$createdAt-${widget.meatData.speciesValue!}-${widget.meatData.primalValue!}-${widget.meatData.secondaryValue!}';

      // 해시함수로 관리번호 생성 및 데이터 저장
      managementNum = hashStringTo12Digits(originalString);
      widget.meatData.id = managementNum;
    } else {
      print('에러');
    }
  }

  // 관리번호 해시 함수
  String hashStringTo12Digits(String input) {
    // 입력 문자열을 UTF-8로 인코딩
    List<int> bytes = utf8.encode(input);

    // 해시 알고리즘으로 SHA-256을 선택
    Digest digest = sha256.convert(bytes);

    // 해시 값을 16진수로 변환
    String hexHash = digest.toString();

    // 앞에서부터 12자리를 추출
    String twelveDigits = hexHash.substring(0, 12);

    return twelveDigits;
  }

  // 이미지를 파이어베이스에 저장
  Future<void> sendImageToFirebase() async {
    try {
      // fire storage에 육류 이미지 저장
      final refMeatImage = FirebaseStorage.instance
          .ref()
          .child('sensory_evals/$managementNum-0.png');

      await refMeatImage.putFile(
        File(widget.meatData.imagePath!),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // QR 생성 후 firestore에 업로드
      await uploadQRCodeImageToStorage(managementNum);
    } catch (e) {
      print(e);
      context.go('/option/error');
    }
  }

  // QR생성 및 전송
  Future<void> uploadQRCodeImageToStorage(String data) async {
    // QR코드 생성
    final qrPainter = QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: true,
    );
    // image 파일로 변환
    final image = await qrPainter.toImage(200);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    // fire storage에 저장
    final storageRef =
        FirebaseStorage.instance.ref().child('qr_codes/$data.png');
    await storageRef.putData(bytes);
  }

  // 육류 정보를 서버로 전송
  Future<void> sendMeatData(MeatData meatData) async {
    // 데이터 전송

    final response1 =
        await ApiServices.sendMeatData(null, meatData.convertNewMeatToJson());
    final response2 = await ApiServices.sendMeatData(
        'sensory_eval', meatData.convertFreshMeatToJson(0));
    if (response1 == null || response2 == null) {
      if (!mounted) return;
      context.go('/option/error');
    } else {
      // 로딩상태 비활성화
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? Text('관리번호 생성중')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(
                    Icons.check_circle_outline,
                    size: 50,
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Text(
                    '관리번호',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    managementNum,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SaveButton(
                          onPressed: () => context.go('/option'),
                          text: '홈으로 이동',
                          width: 305.w,
                          heigh: 104.h,
                          isWhite: false,
                          color: Color.fromRGBO(125, 125, 125, 1),
                        ),
                        SizedBox(
                          width: 46.w,
                        ),
                        SaveButton(
                          onPressed: () => context.go('/option/data-add-home'),
                          text: '추가정보 입력',
                          width: 305.w,
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
