import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buspassfinal/MODEL/vechile.dart';

class VehicleService {
  final String baseUrl = 'http://localhost:3006/api/vehicle';

  Future<void> submitVehicleRequest(VehicleRequest request) async {
    final url = Uri.parse('$baseUrl/request');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(request.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Vehicle request submitted successfully');
      } else {
        throw Exception('Failed to submit vehicle request');
      }
    } catch (error) {
      print('Error submitting vehicle request: $error');
      throw error;
    }
  }
}
