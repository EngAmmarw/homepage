import 'package:flutter/material.dart';
import 'package:homepage/screens/bank_account_screen.dart';
import 'package:homepage/screens/home_screen.dart'; // Import your other screens
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int _currentIndex = 4; // Set initial index to More

  // List of screens for navigation
  final List<Widget> _screens = [
    HomeScreen(),
    MyCardScreen(),
    StatisticsScreen(),
    MyAccountScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: ListView(
        children: [
          // Profile Setting Section
          ListTile(
            title: Text(
              'Profile Setting',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Personal Info'),
            onTap: () {
              // Navigate to Personal Info screen
            },
          ),
          ListTile(
            title: Text('Notification Preference'),
            onTap: () {
              // Navigate to Notification Preference screen
            },
          ),
          ListTile(
            title: Text('Security Setting'),
            onTap: () {
              // Navigate to Security Setting screen
            },
          ),
          ListTile(
            title: Text('Language & Theme'),
            onTap: () {
              // Navigate to Language & Theme screen
            },
          ),
          Divider(),
          // Services Section
          ListTile(
            title: Text(
              'Services',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Loans'),
            onTap: () {
              // Navigate to Loans screen
            },
          ),
          ListTile(
            title: Text('Investments'),
            onTap: () {
              // Navigate to Investments screen
            },
          ),
          ListTile(
            title: Text('Insurance'),
            onTap: () {
              // Navigate to Insurance screen
            },
          ),
          Divider(),
          // Customer Support Section
          ListTile(
            title: Text(
              'Customer Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('FAQs'),
            onTap: () {
              // Navigate to FAQs screen
            },
          ),
          ListTile(
            title: Text('Contact Us'),
            onTap: () {
              // Navigate to Contact Us screen
            },
          ),
          ListTile(
            title: Text('Feedback Form'),
            onTap: () {
              // Navigate to Feedback Form screen
            },
          ),
          Divider(),
          // About Us Section
          ListTile(
            title: Text(
              'About Us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to About Us screen
            },
          ),
          Divider(),
          // Logout
          ListTile(
            title: Center(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              // Perform logout action
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 68, 18, 78),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Cards"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Statistics"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: "Accounts"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }
}
