import 'package:flutter/material.dart';
import 'package:homepage/screens/account_screen.dart';
import 'package:homepage/screens/bank_account_screen.dart';
import 'package:homepage/screens/home_screen.dart'; // Import your other screens
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int _currentIndex = 4; // Set initial index to More

  // List of screens for navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const MyCardScreen(),
    const StatisticsScreen(),
    const MyAccountScreen(),
    const MoreScreen(),
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
        title: const Text('More'),
        leading: null,
      ),
      body: ListView(
        children: [
          // Profile Setting Section
          const ListTile(
            title: Text(
              'Profile Setting',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Personal Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Notification Preference'),
            onTap: () {
              // Navigate to Notification Preference screen
            },
          ),
          ListTile(
            title: const Text('Security Setting'),
            onTap: () {
              // Navigate to Security Setting screen
            },
          ),
          ListTile(
            title: const Text('Language & Theme'),
            onTap: () {
              // Navigate to Language & Theme screen
            },
          ),
          const Divider(),
          // Services Section
          const ListTile(
            title: Text(
              'Services',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Loans'),
            onTap: () {
              // Navigate to Loans screen
            },
          ),
          ListTile(
            title: const Text('Investments'),
            onTap: () {
              // Navigate to Investments screen
            },
          ),
          ListTile(
            title: const Text('Insurance'),
            onTap: () {
              // Navigate to Insurance screen
            },
          ),
          const Divider(),
          // Customer Support Section
          const ListTile(
            title: Text(
              'Customer Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('FAQs'),
            onTap: () {
              // Navigate to FAQs screen
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              // Navigate to Contact Us screen
            },
          ),
          ListTile(
            title: const Text('Feedback Form'),
            onTap: () {
              // Navigate to Feedback Form screen
            },
          ),
          const Divider(),
          // About Us Section
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Navigate to About Us screen
            },
          ),
          const Divider(),
          // Logout
          ListTile(
            title: const Center(
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
        selectedItemColor: const Color.fromARGB(255, 68, 18, 78),
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
