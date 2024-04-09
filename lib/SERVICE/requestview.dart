import 'dart:convert';
import 'package:buspassfinal/MODEL/Request%20view.dart';
import 'package:http/http.dart' as http;

class HodService {
  static const String baseUrl = 'http://localhost:3006/api/viewHod';

  Future<List<Hod>> fetchAllHods() async {
    final response = await http.get(Uri.parse('$baseUrl/viewHod'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['hodDetails'];
      return jsonData.map((e) => Hod.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load HOD details');
    }
  }
}
