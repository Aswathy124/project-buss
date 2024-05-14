import 'dart:convert';

import 'package:http/http.dart' as http;

class DeleteService {
  static const String baseUrl = 'http://localhost:3006/api';

  static Future<void> deleteDayscholar(String id) async {
    final url = Uri.parse('$baseUrl/delete/dayscholar/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete dayscholar');
    }
  }
}
