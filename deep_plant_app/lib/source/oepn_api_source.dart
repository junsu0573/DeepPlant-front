import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class OpenApiSource {
  String baseUrl;
  OpenApiSource({
    required this.baseUrl,
  });

  Future<dynamic> getJsonData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final xml2JsonData = Xml2Json()..parse(body);
      final jsonData = xml2JsonData.toParker();

      final parsingData = jsonDecode(jsonData);

      return parsingData;
    } else {
      print(response.statusCode);
    }
  }
}
