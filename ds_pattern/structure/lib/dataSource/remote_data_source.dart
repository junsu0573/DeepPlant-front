import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class RemoteDataSource {
  static String baseUrl = 'http://3.38.52.82';

  // 육류 정보 전송 (POST)
  static Future<dynamic> sendMeatData(String? dest, String jsonData) async {
    String endPoint = 'meat/add';
    if (dest != null) {
      endPoint = 'meat/add/$dest';
    }
    dynamic response = await _postApi(endPoint, jsonData);
    return response;
  }

  // 유저 회원가입 (POST)
  static Future<dynamic> signUp(String jsonData) async {
    dynamic response = await _postApi('user/register', jsonData);
    return response;
  }

  // 유저 업데이트 (POST)
  static Future<dynamic> updateUser(String jsonData) async {
    dynamic response = await _postApi('user/update', jsonData);
    return response;
  }

  // 유저 비밀번호 변경 (POST)
  static Future<dynamic> changeUserPw(String jsonData) async {
    dynamic response = await _postApi('user/update', jsonData);
    return response;
  }

  // 유저 비밀번호 검사 (POST)
  static Future<dynamic> checkUserPw(String jsonData) async {
    dynamic response = await _postApi('user/pwd_check', jsonData);
    return response;
  }

  // 육류 정보 조회 (GET)
  static Future<dynamic> receiveMeatData(String? dest) async {
    dynamic endPoint = 'meat/get';
    if (dest != null) {
      endPoint = 'meat/get/$dest';
    }
    dynamic response = await _getApi(endPoint);
    return response;
  }

  // 관리번호 육류 정보 조회 (GET)
  static Future<dynamic> getMeatData(String id) async {
    dynamic response = await _getApi('meat/get?id=$id');
    return response;
  }

  // 승인된 관리번호 부분 검색 (GET)
  static Future<dynamic> searchMeatId(String text) async {
    dynamic response = await _getApi('meat/get?part_id=$text');
    return response;
  }

  // 딥에이징 데이터 삭제 (GET)
  static Future<dynamic> deleteDeepAging(String id, int seqno) async {
    dynamic response =
        await _getApi('meat/delete/deep_aging?id=$id&seqno=$seqno');
    return response;
  }

  // 승인된 관리번호 검색
  static Future<dynamic> getConfirmedMeatData() async {
    dynamic response = await _getApi('meat/status?statusType=2');
    return response;
  }

  // 유저가 등록한 관리번호 조회 (GET)
  static Future<dynamic> getUserMeatData(String? dest) async {
    String endPoint = 'meat/user';
    if (dest != null) {
      endPoint = 'meat/user$dest';
    }
    dynamic response = await _getApi(endPoint);
    return response;
  }

  // 등록자 필터 정보 조회 (GET)
  static Future<dynamic> getUserTypeData(String type) async {
    dynamic response = await _getApi('meat/user?userType=$type');
    return response;
  }

  // 육류 데이터 승인 (GET)
  static Future<dynamic> confirmMeatData(String meatId) async {
    dynamic response = await _getApi('meat/confirm?id=$meatId');
    return response;
  }

  // 등록자 필터 정보 조회(GET)
  static Future<dynamic> getMyData(String id) async {
    dynamic response = await _getApi('meat/user?userId=$id');
    return response;
  }

  // 기간 내 데이터 조회 (GET)
  static Future<dynamic> getCreatedAtData(
      int count, String start, String end) async {
    dynamic response =
        await _getApi('meat/get?offset=0&count=$count&start=$start&end=$end');
    return response;
  }

  // 유저 로그인 (GET)
  static Future<dynamic> signIn(String userId) async {
    dynamic response = await _getApi('user/login?id=$userId');
    return response;
  }

  // 유저 중복검사 (GET)
  static Future<dynamic> dupliCheck(String userId) async {
    dynamic response = await _getApi('user/duplicate_check?id=$userId');
    return response;
  }

  // 종, 부위 조회 (GET)
  static Future<dynamic> getMeatSpecies() async {
    dynamic response = await _getApi('data');
    return response;
  }

  // API POST
  static Future<dynamic> _postApi(String endPoint, String jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String requestBody = jsonData;

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      if (response.statusCode == 200) {
        print('POST 요청 성공');
        print(response.body);
        return response.body;
      } else {
        print('POST 요청 실패: (${response.statusCode})${response.body}');
        return;
      }
    } catch (e) {
      print('POST 요청 중 예외 발생: $e');
      return;
    }
  }

  // API GET
  static Future<dynamic> _getApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('GET 요청 성공');
        return jsonDecode(response.body);
      } else {
        print('GET 요청 실패: (${response.statusCode})${response.body}');
        return;
      }
    } catch (e) {
      print('GET 요청 중 예외 발생: $e');
      return;
    }
  }

  // 육류 이미지 firebase 저장 (POST)
  static Future<dynamic> sendImageToFirebase(
      String imagePath, String imageDest) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    try {
      final refMeatImage = firebaseStorage.ref().child('$imageDest.png');

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

  // 육류 이력관리 정보 (GET)
  static Future<dynamic> getMeatTraceData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = utf8.decode(response.bodyBytes);
        final xml2JsonData = Xml2Json()..parse(body);
        final jsonData = xml2JsonData.toParker();

        final parsingData = jsonDecode(jsonData);

        return parsingData;
      } else {
        print(response.statusCode);
        return;
      }
    } catch (e) {
      print("error");
      return;
    }
  }
}
