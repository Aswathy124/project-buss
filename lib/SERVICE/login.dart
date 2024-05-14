import 'dart:convert';
import 'package:buspassfinal/MODEL/login.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://localhost:3006/api/login'; // Replace with your backend URL

  static Future<Map<String, dynamic>> loginUser(User user) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
