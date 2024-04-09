import 'dart:convert';
import 'package:buspassfinal/MODEL/registerday.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'http://localhost:3006/api/dayscholar'; // Replace with your backend base URL

  static Future submitDayScholarForm(DayScholar dayScholar) async {
    final url = Uri.parse('$baseUrl/dayscholar');
    final response = await http.post(
      url,
      body: json.encode(dayScholar.toJson()), // <-- Here is where you're using .json
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      // If the server returns a 201 CREATED response,
      // then parse the JSON and return it.
      return json.decode(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to submit form');
    }
  }
}
