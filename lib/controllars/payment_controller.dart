// Controllers/payment_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/payment_request.dart';
import '../models/payment_response.dart';

class PaymentController {
  final BuildContext context;
  bool isLoading = false;

  PaymentController({required this.context});

  Future<void> makePayment(PaymentRequest paymentRequest) async {
    const String apiUrl =
        'https://ptechapp-5ab6d15ba23c.herokuapp.com/payments/transfer';

    try {
      // Set loading to true
      isLoading = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(paymentRequest.toJson()),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = PaymentResponse.fromJson(jsonDecode(response.body));

        if (data.success) {
          // Navigate to CongratsScreen after successful payment
          Navigator.pushNamed(context, '/congrats');
        } else {
          _showSnackBar('Payment Failed: Something went wrong');
        }
      } else {
        _showSnackBar('Payment Failed: ${response.body}');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    } finally {
      // Set loading to false
      isLoading = false;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
