import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompleteResgistration extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  const CompleteResgistration({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<CompleteResgistration> createState() => _CompleteResgistrationState();
}

class _CompleteResgistrationState extends State<CompleteResgistration> {
  String managementNumber = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.meatData.traceNum != null &&
        widget.meatData.speciesValue != null &&
        widget.meatData.primalValue != null &&
        widget.meatData.secondaryValue != null) {
      managementNumber =
          '${widget.meatData.traceNum!}-${widget.meatData.!}-${widget.meatData.lDivision!}-${widget.meatData.sDivision!}';
    }

    sendDataToFirebase();
  }

  Future<void> sendDataToFirebase() async {
    setState(() {
      isLoading = true;
    });
    try {
      // meat 컬렉션에 데이터 저장
      final refData = firestore.collection('meat').doc(managementNumber);

      DateTime now = DateTime.now();

      String saveDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

      await refData.set({
        'traceNumber': widget.meatData.historyNumber,
        'species': widget.meatData.species,
        'l_division': widget.meatData.lDivision,
        's_division': widget.meatData.sDivision,
        'fresh': widget.meatData.freshData,
        'email': widget.user.email,
        'saveTime': saveDate,
        'gradeNm': widget.meatData.gradeNm,
        'farmAddr': widget.meatData.butcheryPlaceNm,
        'butcheryPlaceNm': widget.meatData.butcheryPlaceNm,
        'butcheryYmd': widget.meatData.butcheryYmd,
      });

      // 0-0-0-0-0 에 관리번호 저장
      DocumentReference documentRef =
          firestore.collection('meat').doc('0-0-0-0-0');
      await documentRef.update({
        'fix_data.meat': FieldValue.arrayUnion([managementNumber]),
      });

      // 0-0-0-0-0 에 유저 이메일 추가
      await documentRef.update({
        'fix_data.${widget.user.level}':
            FieldValue.arrayUnion([widget.user.email]),
      });

      // user의 meatList에 관리번호 추가
      DocumentReference refNum =
          firestore.collection(widget.user.level!).doc(widget.user.email);
      List<dynamic> newNum = [managementNumber];
      await refNum.update({'meatList': FieldValue.arrayUnion(newNum)});

      // fire storage에 육류 이미지 저장
      final refMeatImage =
          FirebaseStorage.instance.ref().child('meats/$managementNumber.png');

      await refMeatImage.putFile(
        File(widget.meatData.imageFile!),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // QR 생성 후 firestore에 업로드
      uploadQRCodeImageToStorage(managementNumber);
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
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
                    managementNumber,
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
                    margin: EdgeInsets.only(bottom: 10),
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
