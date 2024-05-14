import 'dart:convert';
import 'package:buspassfinal/MODEL/download.dart';
import 'package:http/http.dart' as http;



class DayscholarService {
  static const String baseUrl = 'http://localhost:3006/api/download/download';

  static Future<void> downloadPdf(Dayscholar dayscholar) async {
    const url = '$baseUrl/download';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': dayscholar.name,
          'department': dayscholar.department,
          'admissionNo': dayscholar.admissionNo,
          'place': dayscholar.place,
          'busNo': dayscholar.busNo,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful download
      } else {
        throw Exception('Failed to load PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to download PDF: $e');
    }
  }
}
