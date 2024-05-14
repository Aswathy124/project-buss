import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buspassfinal/MODEL/viewhostler.dart';

class PassDetailsService {
  static const String baseUrl = 'http://localhost:3006/api/viewAll/viewAll'; // replace with your API base URL

  static Future<List<PassDetails>> fetchPassDetails() async {
    final response = await http.get(Uri.parse('$baseUrl'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['passDetails'];
      return data.map((json) => PassDetails.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pass details');
    }
  }
}
