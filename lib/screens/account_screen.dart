import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homepage/globals/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:homepage/models/user.dart'; // Import the user model

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? user; // User data
  bool isLoading = true; // To handle loading state

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch the user data when the screen loads
  }

  // Function to fetch user data from the API
  Future<void> _fetchUserData() async {
    const String apiUrl = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/users';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          user = User.fromJson(data); // Parse the JSON and store in user
          isLoading = false; // Stop loading once data is fetched
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show a loading spinner while fetching data
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Avatar and Name Section
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            "${GlobalVariables.firstName.toString()} ${GlobalVariables.lastName.toString()}",
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${GlobalVariables.firstName.toString()} ${GlobalVariables.lastName.toString()}", // Display user's full name
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          GlobalVariables.email ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  // Personal Information Section
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('First Name'),
                          subtitle: Text(GlobalVariables.firstName ?? ''),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            // Handle edit first name
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Last Name'),
                          subtitle: Text(GlobalVariables.lastName ?? ''),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            // Handle edit last name
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(GlobalVariables.email ?? ''),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            // Handle edit email
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          subtitle: Text(GlobalVariables.language ?? ''),
                          trailing: const Icon(Icons.edit),
                          onTap: () {
                            // Handle edit language
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Security Section
                  const Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.lock),
                          title: const Text('Change Password'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to change password screen
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.security),
                          title: const Text('Two-Factor Authentication'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Navigate to two-factor authentication settings
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Linked Accounts Section
                  const Text(
                    'Linked Accounts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text('Linked Accounts'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to linked accounts screen
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle logout action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        foregroundColor: Colors.redAccent,
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
