import 'package:buspassfinal/MODEL/request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class HodService {
  static const String baseUrl = 'http://localhost:3006/api/hod'; // Update with your API URL

  static Future submitHodForm(HodModel hod) async {
    final url = Uri.parse('$baseUrl/hod');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': hod.name,
        'department': hod.department,
        'reason': hod.reason,
        'bus': hod.bus,
        'studentEmail': hod.studentEmail,
        'hodName': hod.hodName,
        'hodMail': hod.hodMail,
        'tutorName': hod.tutorName,
        'tutorMail': hod.tutorMail,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to submit form');
    }
  }
}
