import 'package:flutter/material.dart';
import 'package:homepage/screens/bank_account_screen.dart';
import 'package:homepage/screens/more_screen.dart';
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/transaction_page.dart'; // Import the TransactionPage
import 'package:homepage/screens/transfer_money_screen.dart';
import 'package:homepage/widgets/transaction_item.dart';
import '../widgets/credit_card_widget.dart';
import '../widgets/service_tile.dart';
import 'statistics_screen.dart';
// Other imports remain the same
import 'package:homepage/screens/profile_screen.dart'; // Make sure to import your profile screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // Replace with the actual Home widget if needed
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
      MaterialPageRoute(
        builder: (context) => _screens[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Set a custom height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // Remove the back button
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                // Profile Picture with GestureDetector to handle tap
                GestureDetector(
                  onTap: () {
                    // Navigate to ProfileScreen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ProfileScreen(), // Define your profile screen widget
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 24, // Adjust the size as needed
                    backgroundImage: AssetImage(
                        'assets/P_TECH.png'), // Update with your asset path
                  ),
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
                      const Text(
                        "Ammar!",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow
                            .ellipsis, // Prevent overflow by ellipsis
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Pushes the notification icon to the right
                IconButton(
                  iconSize: 30.0, // Set the size of the icon
                  icon: const Icon(Icons.notifications, color: Colors.black),
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
                      width: screenWidth * 0.75,
                      imagePath:
                          'assets/cardimage.png', // Pass responsive width
                    ),
                    const SizedBox(width: 16),
                    CreditCardWidget(
                      cardName: "Y-Card",
                      balance: "\$2,664.63", // Mock balance data
                      lastDigits: "7897",
                      width: screenWidth * 0.75, // Pass responsive width
                      imagePath:
                          'assets/cardimage.png', // Pass responsive width
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.grey),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Incoming Transactions",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionPage(),
                        ),
                      );
                    },
                    child: const Text("See All"),
                  ),
                ],
              ),
              const TransactionItem(
                icon: Icons.apple,
                title: 'Apple Store',
                subtitle: '4 Sep 2024 \n 12:32 AM',
                amount: '- \$5,99',
              ),
              const TransactionItem(
                icon: Icons.music_note,
                title: 'Spotify',
                subtitle: '4 Sep 2024 \n 12:32 AM',
                amount: '- \$12,99',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Outgoing Transactions",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionPage(),
                        ),
                      );
                    },
                    child: const Text("See All"),
                  ),
                ],
              ),
              // Placeholder for outgoing transactions
              const TransactionItem(
                icon: Icons.movie,
                title: 'Netflix',
                subtitle: '4 Sep 2024 \n 12:32 AM',
                amount: '- \$5,99',
              ),
              const TransactionItem(
                icon: Icons.shopping_cart_sharp,
                title: 'Amazon',
                subtitle: '4 Sep 2024 \n 12:32 AM',
                amount: '- \$12,99',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
              icon: Icon(Icons.credit_card), label: "My Card"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Statistics"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), label: "My Account"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.currency_exchange_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const PaymentScreen(), // Make sure to define TransferMoneyScreen
            ),
          );
        },
      ),
    );
  }
}
