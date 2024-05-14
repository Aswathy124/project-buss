import 'package:flutter/foundation.dart';

class Payment {
  final int amount;
  final String status;
  final DateTime paymentDate;

  Payment({
    required this.amount,
    required this.status,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      amount: json['amount'],
      status: json['status'],
      paymentDate: DateTime.parse(json['paymentDate']),
    );
  }
}
