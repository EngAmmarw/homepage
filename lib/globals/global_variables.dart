import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class GlobalVariables {
  static String? userAccountID;
  static String? username;
  static String? firstName;
  static String? lastName;
  static String? email;
  static String? language;
  static double? balance;

  // Function to set the user data
  static void setUserData(UserData data) {
    userAccountID = data.userAccountID;
    username = data.username;
    firstName = data.firstName;
    lastName = data.lastName;
    email = data.email;
    language = data.language;
  }

  // Function to clear user data
  static void clearUserData() {
    userAccountID = null;
    username = null;
    firstName = null;
    lastName = null;
    email = null;
    language = null;
    balance = null;
  }

  // Function to fetch and set the balance based on the userAccountID
  static Future<void> fetchUserBalance() async {
    if (userAccountID == null) return;

    final url =
        'https://ptechapp-5ab6d15ba23c.herokuapp.com/users/$userAccountID';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('balance')) {
          balance = double.tryParse(data['balance']) ?? 0.0;
        } else {
          print('Balance not found for userAccountID: $userAccountID');
        }
      } else {
        print('Failed to fetch balance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching balance: $e');
    }
  }
}
