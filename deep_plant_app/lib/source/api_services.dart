import 'dart:convert';

import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = '';

  // API POST
  static Future<void> _postApi(String endPoint, String jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String requestBody = jsonData;

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);
      if (response.statusCode == 200) {
        print('POST 요청 성공');
        print(response.body);
      } else {
        print('POST 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('POST 요청 중 예외 발생: $e');
    }
  }

  // API GET
  static Future<dynamic> _getApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('GET 요청 실패: ${response.statusCode}');
        return;
      }
    } catch (e) {
      print('GET 요청 중 예외 발생: $e');
      return;
    }
  }

  // 육류 정보 전송 (POST)
  static Future<void> sendMeatData(String? dest, String jsonData) async {
    String endPoint = 'meat/add';
    if (dest != null) {
      endPoint = 'meat/add/$dest';
    }
    await _postApi(endPoint, jsonData);
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
}
