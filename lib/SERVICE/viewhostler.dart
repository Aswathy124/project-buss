import 'dart:convert';
import 'package:buspassfinal/MODEL/viewhostler.dart';
import 'package:http/http.dart' as http;

class PassDetailsService {
  static const String baseUrl = 'http://localhost:3006/api/viewAll'; // Replace with your backend URL

  static Future<List<PassDetails>> fetchPassDetails() async {
    final response = await http.get(Uri.parse('$baseUrl/viewAll'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['passDetails'];
      return data.map((json) => PassDetails.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pass details');
    }
  }
}
