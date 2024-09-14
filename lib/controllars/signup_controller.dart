// Controllers/signup_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';

class SignupController {
  final BuildContext context;
  bool isLoading = false;

  SignupController({required this.context});

  Future<void> register(SignupRequest signupRequest) async {
    const String apiUrl =
        'https://ptechapp-5ab6d15ba23c.herokuapp.com/user/register';

    try {
      // Set loading to true
      isLoading = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(signupRequest.toJson()),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = SignupResponse.fromJson(jsonDecode(response.body));

        if (data.success) {
          final userAccountID = data.data!.userAccountID;

          // Save userAccountID to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userAccountID', userAccountID);

          // Navigate to Login page after successful registration
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          _showSnackBar('Signup Failed: Something went wrong');
        }
      } else {
        _showSnackBar('Signup Failed: ${response.body}');
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
