import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../globals/global_variables.dart';

class LoginController {
  final BuildContext context;
  bool isLoading = false;

  LoginController({required this.context});

  Future<void> login(LoginRequest loginRequest) async {
    const String apiUrl =
        'https://ptechapp-5ab6d15ba23c.herokuapp.com/user/authenticate';

    try {
      isLoading = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(loginRequest.toJson()),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = LoginResponse.fromJson(jsonDecode(response.body));

        if (data.success) {
          final userAccountID = data.data!.userAccountID;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userAccountID', userAccountID);

          // Set user data and fetch balance
          GlobalVariables.setUserData(data.data!);
          await GlobalVariables.fetchUserBalance();

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _showSnackBar('Login Failed: Something went wrong');
        }
      } else {
        _showSnackBar('Login Failed: ${response.body}');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    } finally {
      isLoading = false;
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
