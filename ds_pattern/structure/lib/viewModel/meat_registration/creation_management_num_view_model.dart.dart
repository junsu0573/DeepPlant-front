import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:structure/config/userfuls.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class CreationManagementNumViewModel with ChangeNotifier {
  MeatModel meatModel;
  CreationManagementNumViewModel(this.meatModel) {
    _initialize();
  }

  Future<void> _initialize() async {
    // 관리번호 생성
    _createManagementNum();

    // 이미지 저장
    await _sendImageToFirebase();

    // 데이터 전송
    await _sendMeatData();

    isLoading = false;
    notifyListeners();
  }

  String managementNum = '-';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  // 관리번호 생성
  void _createManagementNum() {
    if (meatModel.traceNum != null &&
        meatModel.speciesValue != null &&
        meatModel.primalValue != null &&
        meatModel.secondaryValue != null) {
      // 관리번호: 이력코드-생성일자-종-대분할-소분할
      String createdAt = Usefuls.getCurrentDate();
      String originalString =
          '${meatModel.traceNum!}-$createdAt-${meatModel.speciesValue!}-${meatModel.primalValue!}-${meatModel.secondaryValue!}';

      // 해시함수로 관리번호 생성 및 데이터 저장
      managementNum = _hashStringTo12Digits(originalString);
      meatModel.id = managementNum;
    } else {
      print('에러');
    }
  }

  // 관리번호 해시 함수
  String _hashStringTo12Digits(String input) {
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
  Future<void> _sendImageToFirebase() async {
    try {
      // fire storage에 육류 이미지 저장
      final refMeatImage = FirebaseStorage.instance
          .ref()
          .child('sensory_evals/$managementNum-0.png');

      await refMeatImage.putFile(
        File(meatModel.imagePath!),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      // QR 생성 후 firestore에 업로드
      await uploadQRCodeImageToStorage(managementNum);
    } catch (e) {
      print(e);
      // 에러 페이지
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
  Future<void> _sendMeatData() async {
    meatModel.createUser = meatModel.userId;
    meatModel.createdAt = Usefuls.getCurrentDate();
    meatModel.seqno = 0;

    final response1 =
        await RemoteDataSource.sendMeatData(null, meatModel.toJsonBasic());
    final response2 = await RemoteDataSource.sendMeatData(
        'sensory_eval', meatModel.toJsonFresh(null));

    if (response1 == null || response2 == null) {
      // 에러 페이지
    } else {
      // 로딩상태 비활성화

      isLoading = false;
      notifyListeners();
    }
  }

  void clickedHomeButton(BuildContext context) {
    context.go('/home');
  }
}
