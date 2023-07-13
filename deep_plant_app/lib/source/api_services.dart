import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = '';
  MeatData meatData;
  ApiServices({
    required this.meatData,
  });

  static Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API');
    }
  }
}
