import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:xml2json/xml2json.dart';

class ApiSource {
  final String baseUrl;
  ApiSource({required this.baseUrl});

  Future<dynamic> getJsonData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);
      final Xml2JsonData = Xml2Json()..parse(body);
      final jsonData = Xml2JsonData.toParker();

      final parsingData = convert.jsonDecode(jsonData);

      return parsingData;
    } else {
      print(response.statusCode);
    }
  }
}
