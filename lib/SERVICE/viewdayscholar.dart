import 'dart:convert';
import 'package:http/http.dart' as http;

class DayscholarService {
  static const String baseUrl = 'http://localhost:3006/api/viewDayscholar';

  Future<List<dynamic>> fetchDayscholarDetails() async {
    final url = Uri.parse('$baseUrl/viewDayscholar');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body)['dayDetails'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
