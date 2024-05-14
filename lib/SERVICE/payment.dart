import 'dart:convert';
import 'package:buspassfinal/MODEL/payment.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Payment> processPayment(int amount) async {
    final String url = 'http://localhost:3006/api/payment/payment'; // Change this URL to match your server endpoint
    final Map<String, dynamic> paymentData = {'amount': amount};

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(paymentData),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Payment.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to process payment');
    }
  }
}
