import 'package:flutter/material.dart';
import '../widgets/credit_card_widget.dart';
import '../widgets/service_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Set a custom height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 24, // Adjust the size as needed
                  backgroundImage: AssetImage(
                      'assets/P_TECH.png'), // Update with your asset path
                ),
                const SizedBox(width: 16), // Spacing between profile and text
                // Greeting Text
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        "Ammar!",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow
                            .ellipsis, // Prevent overflow by ellipsis
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Pushes the notification icon to the right
                IconButton(
                  iconSize: 30.0, // Set the size of the icon
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {
                    // Handle notification icon press
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CreditCardWidget(
                      cardName: "X-Card",
                      balance: "\$4,664.63", // Mock balance data
                      lastDigits: "2468",
                      width: screenWidth * 0.75, // Pass responsive width
                    ),
                    const SizedBox(width: 16),
                    CreditCardWidget(
                      cardName: "Y-Card",
                      balance: "\$2,664.63", // Mock balance data
                      lastDigits: "7897",
                      width: screenWidth * 0.75, // Pass responsive width
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                "Quick Actions",
                style: TextStyle(
                    fontSize: screenWidth * 0.055, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: const [
                  ServiceTile(icon: Icons.send, title: "Send money"),
                  ServiceTile(icon: Icons.payment, title: "Pay the bill"),
                  ServiceTile(icon: Icons.request_page, title: "Request"),
                  ServiceTile(icon: Icons.contact_mail, title: "Contact"),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                "Incoming Transactions",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              // Placeholder for incoming transactions
              ListTile(
                title: Text("Incoming Transaction 1"),
                subtitle: Text("Details of the transaction"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to incoming transactions details
                },
              ),
              ListTile(
                title: Text("Incoming Transaction 2"),
                subtitle: Text("Details of the transaction"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to incoming transactions details
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Outgoing Transactions",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              // Placeholder for outgoing transactions
              ListTile(
                title: Text("Outgoing Transaction 1"),
                subtitle: Text("Details of the transaction"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to outgoing transactions details
                },
              ),
              ListTile(
                title: Text("Outgoing Transaction 2"),
                subtitle: Text("Details of the transaction"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to outgoing transactions details
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 68, 18, 78),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Statistics"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "My Card"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.currency_exchange_outlined),
        onPressed: () {
          // Navigate to the transfer money screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TransferMoneyScreen()), // Make sure to define TransferMoneyScreen
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(
                    '/login'); // Replace with actual route
              },
            ),
          ],
        );
      },
    );
  }
}

// Define TransferMoneyScreen here or import from another file
class TransferMoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Money'),
      ),
      body: Center(
        child: Text('Transfer Money Screen'),
      ),
    );
  }
}
