import 'dart:convert';
import 'package:buspassfinal/MODEL/SIGNUP.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://localhost:3006/api/details'; // Change this URL as per your server

  Future<String> addUserDetails(UserDetails userDetails) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userDetails.toJson()),
      );

      if (response.statusCode == 201) {
        return 'User details added successfully';
      } else {
        return 'Failed to add user details';
      }
    } catch (e) {
      return 'Exception while adding user details: $e';
    }
  }
}
