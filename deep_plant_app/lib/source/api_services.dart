import 'dart:convert';

import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = 'http://10.221.71.163:8080';

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

  // 육류 정보 전송 (POST)
  static Future<dynamic> sendMeatData(String? dest, String jsonData) async {
    String endPoint = 'meat/add';
    if (dest != null) {
      endPoint = 'meat/add/$dest';
    }
    return await _postApi(endPoint, jsonData);
  }

  // 육류 정보 조회 (GET)
  static Future<dynamic> receiveMeatData(String? dest) async {
    String endPoint = 'meat/get';
    if (dest != null) {
      endPoint = 'meat/get/$dest';
    }

    print(await _getApi(endPoint));
  }

  // 관리번호 육류 정보 조회 (GET)
  static Future<dynamic> getMeatData(String id) async {
    dynamic data = await _getApi('meat/get?id=$id');
    print(data);
    return data;
  }

  // 승인된 관리번호 부분 검색 (GET)
  static Future<dynamic> searchMeatId(String text) async {
    dynamic jsonData = await _getApi('meat/get?part_id=$text');
    print(jsonData);
    return jsonData;
  }

  // 유저가 등록한 관리번호 조회 (GET)
  static Future<dynamic> getUserMeatData(String? dest) async {
    String endPoint = 'meat/user';
    if (dest != null) {
      endPoint = 'meat/user/$dest';
    }

    print(await _getApi(endPoint));
  }

  // 등록자 필터 정보 조회 (GET)
  static Future<dynamic> getUserTypeData(String type) async {
    dynamic data = await _getApi('meat/user?userType=$type');
    return data;
  }

  // 육류 데이터 승인
  static Future<dynamic> confirmMeatData(String meatId) async {
    dynamic data = await _getApi('meat/confirm?id=$meatId');
    return data;
  }

  // 유저 회원가입 (POST)
  static Future<void> signUp(UserData user) async {
    await _postApi('user/register', user.convertUserSignUpToJson());
  }

  // 유저 로그인 (GET)
  static Future<dynamic> signIn(String userId) async {
    dynamic jsonData = await _getApi('user/login?id=$userId');
    return jsonData;
  }

  // 유저 로그아웃 (GET)
  static Future<dynamic> signOut(String userId) async {
    dynamic jsonData = await _getApi('user/logout?id=$userId');
    return jsonData;
  }

  // 유저 업데이트 (POST)
  static Future<dynamic> updateUser(UserData user) async {
    await _postApi('user/update', user.convertUserUpdateToJson());
  }

  // 유저 중복검사 (GET)
  static Future<bool> dupliCheck(String userId) async {
    dynamic data = await _getApi('user/duplicate_check?id=$userId');
    if (data == null) {
      // 404: 중복
      return true;
    } else {
      // 200: !중복
      return false;
    }
  }

  // 종, 부위 조회 (GET)
  static Future<dynamic> getMeatSpecies() async {
    dynamic jsonData = await _getApi('data');
    return jsonData;
  }
}
