import 'dart:convert';
import 'package:buspassfinal/MODEL/buspass.dart';
import 'package:http/http.dart' as http;


class BusPassService {
  static const String baseUrl = 'http://localhost:3006/api/register'; // Replace with your backend URL

  Future<void> submitBusPass(BusPassModel busPass) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(busPass.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Bus pass submitted successfully');
      } else {
        throw Exception('Failed to submit bus pass');
      }
    } catch (e) {
      print('Error submitting bus pass: $e');
      throw Exception('Failed to submit bus pass');
    }
  }
}
