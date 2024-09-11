import 'package:flutter/material.dart';
import 'package:homepage/screens/home_screen.dart'; // Import your other screens
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';
import 'package:homepage/screens/more_screen.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  int _currentIndex = 3; // Set initial index to Accounts
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
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyCardScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StatisticsScreen()),
        );
        break;
      case 3:
        // Do nothing, already on Accounts screen
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MoreScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Checking Account Card
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Checking Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Balance: 2,500 \$'),
                  Text('Last Transaction: -100 \$ (Debit)'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to View Details screen
                        },
                        child: Text('View Details'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Transfer Money screen
                        },
                        child: Text('Transfer Money'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Saving Account Card
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saving Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Balance: 1,000 \$'),
                  Text('Last Transaction: +100 \$ (Credit)'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to View Details screen
                        },
                        child: Text('View Details'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Transfer Money screen
                        },
                        child: Text('Transfer Money'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Loan Account Card
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loan Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Balance: -15,000 \$'),
                  Text('Next Payment: 500 \$ (due)'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to View Details screen
                        },
                        child: Text('View Details'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Pay Loan screen
                        },
                        child: Text('Pay Loan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
