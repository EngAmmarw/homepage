import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '/Models/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User_Model.dart';

class UserController {
  final BuildContext context;
  bool isLoading = false;

  UserController({required this.context});

  Future<void> registerUser(UserModel user) async {
    const String apiUrl =
        'https://ptechapp-5ab6d15ba23c.herokuapp.com/user/register';

    try {
      // Set loading to true
      isLoading = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(user.toJson()),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Body: ${response.body}');

      // Handle response
      if (response.statusCode == 201 &&
          response.body != '''{"success":false}''') {
        final data = UserResponse.fromJson(jsonDecode(response.body));
        final userId = data.data.userId;

        log('data: $data');
        log('userId: $userId');

        // Save userId to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId); // Save user ID

        // Navigate to HomePage after successful registration
        Navigator.pushReplacementNamed(context, '/home', arguments: userId);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Registration failed. Please try again.';
        _showSnackBar('Registration Failed: $errorMessage');
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
