import 'package:flutter/material.dart';
import 'package:homepage/screens/home_screen.dart'; // Import your other screens
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';
import 'package:homepage/screens/more_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  int _currentIndex = 3; // Set initial index to Accounts

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyCardScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StatisticsScreen()),
        );
        break;
      case 3:
        // Do nothing, already on Accounts screen
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MoreScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E), // Gradient Start
                Color(0xFF374577), // Gradient End
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Accounts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAccountCard(
            title: 'Checking Account',
            balance: '2,500 \$',
            lastTransaction: '-100 \$ (Debit)',
            onViewDetails: () {
              // Navigate to View Details
            },
            onTransferMoney: () {
              // Navigate to Transfer Money
            },
            icon: Icons.account_balance_wallet,
            backgroundColor: const Color.fromARGB(255, 151, 221, 219),
          ),
          _buildAccountCard(
            title: 'Saving Account',
            balance: '1,000 \$',
            lastTransaction: '+100 \$ (Credit)',
            onViewDetails: () {
              // Navigate to View Details
            },
            onTransferMoney: () {
              // Navigate to Transfer Money
            },
            icon: Icons.savings,
            backgroundColor: const Color.fromARGB(255, 107, 156, 212),
          ),
          _buildAccountCard(
            title: 'Loan Account',
            balance: '-15,000 \$',
            lastTransaction: 'Next Payment: 500 \$ (due)',
            onViewDetails: () {
              // Navigate to View Details
            },
            onTransferMoney: () {
              // Navigate to Pay Loan
            },
            icon: Icons.attach_money,
            backgroundColor: const Color.fromARGB(255, 120, 103, 184),
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

  Widget _buildAccountCard({
    required String title,
    required String balance,
    required String lastTransaction,
    required VoidCallback onViewDetails,
    required VoidCallback onTransferMoney,
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: Colors.black54),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Balance: $balance',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              lastTransaction,
              style: const TextStyle(fontSize: 16, color: Colors.black45),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onViewDetails,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('View Details'),
                ),
                ElevatedButton(
                  onPressed: onTransferMoney,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Transfer Money'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
