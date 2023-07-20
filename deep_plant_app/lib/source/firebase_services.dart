import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // 이미지를 파이어베이스에 저장
  static Future<dynamic> sendImageToFirebase(
      String meatId, String imagePath) async {
    try {
      final refMeatImage =
          _firebaseStorage.ref().child('sensory_evals/$meatId-0.png');

      await refMeatImage.putFile(
        File(imagePath),
        SettableMetadata(contentType: 'image/jpeg'),
      );
      return '이미지 전송 성공';
    } catch (e) {
      print(e);
      return;
    }
  }
}
