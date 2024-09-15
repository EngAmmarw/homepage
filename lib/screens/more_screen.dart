import 'package:flutter/material.dart';
import 'package:homepage/screens/account_screen.dart';
import 'package:homepage/screens/bank_account_screen.dart';
import 'package:homepage/screens/home_screen.dart';
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with TickerProviderStateMixin {
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
        title: const Text(
          'More',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E), // Baby Blue
                Color(0xFF374577), // Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Animated Card for Profile Settings
          Text(
            'Profile Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 57, 36, 132)),
          ),
          const SizedBox(height: 10),

          _buildAnimatedCard(
            title: 'Personal Info',
            icon: Icons.person,
            subtitle: 'Manage your personal information',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Notification Preferences',
            icon: Icons.notifications,
            subtitle: 'Set your notification settings',
            onTap: () {
              // Navigate to Notification Preferences screen
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Security Settings',
            icon: Icons.lock,
            subtitle: 'Manage your security options',
            onTap: () {
              // Navigate to Security Settings screen
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Language & Theme',
            icon: Icons.palette,
            subtitle: 'Change language or theme',
            onTap: () {
              // Navigate to Language & Theme screen
            },
          ),
          const Divider(height: 40, color: Colors.grey),
          Text(
            'Services',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF392484)),
          ),
          const SizedBox(height: 10),
          _buildAnimatedCard(
            title: 'Loans',
            icon: Icons.account_balance_wallet,
            subtitle: 'Explore loan options',
            onTap: () {
              // Navigate to Loans screen
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Investments',
            icon: Icons.trending_up,
            subtitle: 'Investment opportunities',
            onTap: () {
              // Navigate to Investments screen
            },
          ),
          const Divider(height: 40, color: Colors.grey),
          Text(
            'Customer Support',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 57, 36, 132)),
          ),
          const SizedBox(height: 10),
          _buildAnimatedCard(
            title: 'FAQs',
            icon: Icons.help_outline,
            subtitle: 'Frequently Asked Questions',
            onTap: () {
              // Navigate to FAQs screen
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Contact Us',
            icon: Icons.phone,
            subtitle: 'Get in touch with us',
            onTap: () {
              // Navigate to Contact Us screen
            },
          ),
          const SizedBox(height: 20),
          _buildAnimatedCard(
            title: 'Feedback Form',
            icon: Icons.feedback,
            subtitle: 'Send us your feedback',
            onTap: () {
              // Navigate to Feedback Form screen
            },
          ),
          const Divider(height: 40, color: Colors.grey),
          _buildAnimatedCard(
            title: 'Logout',
            icon: Icons.logout,
            isLogout: true,
            onTap: () {
              // Perform logout action
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF44124E),
        unselectedItemColor: const Color(0xFF374577),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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

  // Helper function to create animated cards
  Widget _buildAnimatedCard({
    required String title,
    required IconData icon,
    String? subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: isLogout
              ? LinearGradient(
                  colors: [
                    Colors.red.shade400,
                    const Color.fromARGB(255, 229, 57, 53)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFF394A85), Color(0xFF394A85)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  // Section title
}
