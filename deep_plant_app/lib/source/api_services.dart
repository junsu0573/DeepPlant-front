import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = '';

  // API POST
  static Future<void> _postData(String endPoint, String jsonData) async {
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
  static Future<dynamic> _getData(String endPoint) async {
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

  // 육류 정보 전송
  static Future<void> sendMeatData(String jsonData) async {
    _postData('meat/set', jsonData);
  }

  // 유저 로그인
  static Future<void> signIn() async {
    _getData('user/login');
  }

  // 유저 로그아웃
  static Future<dynamic> signOut() async {
    dynamic jsonData = await _getData('user/logout');
    return jsonData;
  }
}
