import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buspassfinal/MODEL/viewhostler.dart';

class SearchService {
  static const String baseUrl = 'http://localhost:3006/api/search'; // replace with your API base URL

  static Future<List<PassDetails>> search(String from, String to) async {
    final response = await http.get(Uri.parse('$baseUrl/search?from=$from&to=$to'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PassDetails.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search pass details');
    }
  }
}
