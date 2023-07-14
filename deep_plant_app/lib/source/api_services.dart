import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = '';

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
      // 예외가 발생했습니다.
      print('POST 요청 중 예외 발생: $e');
    }
  }
}
