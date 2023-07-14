import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = '';

  // 육류 정보 전송
  static Future<void> postMeatData(String jsonData) async {
    String apiUrl = '$baseUrl/meat/set';
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

  // 유저 정보 읽기
  static Future<void> getUserInfo(String jsonData) async {
    String apiUrl = '$baseUrl/user/set';
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
}
