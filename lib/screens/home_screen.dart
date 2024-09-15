import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homepage/globals/global_variables.dart';
import 'package:homepage/screens/bills_payment_screen.dart';
import 'package:homepage/screens/contacts_screen.dart';
import 'package:homepage/screens/donation_screen.dart';
import 'package:homepage/screens/e_wallet_screen.dart';
import 'package:homepage/screens/request_money_screen.dart';
import 'package:http/http.dart' as http;
import 'package:homepage/models/user.dart'; // Import the User model
import 'package:homepage/screens/profile_screen.dart';
import 'package:homepage/widgets/credit_card_widget.dart';
import 'package:homepage/widgets/service_tile.dart';
import 'package:homepage/screens/notification_screen.dart';
import 'package:homepage/screens/my_cards_screen.dart';
import 'package:homepage/screens/statistics_screen.dart';
import 'package:homepage/screens/more_screen.dart';
import 'package:homepage/screens/transaction_page.dart';
import '../widgets/transaction_item.dart';
import 'bank_account_screen.dart';
import 'transfer_money_screen.dart'; // Import PaymentScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  User? user; // User data
  bool isLoading = true; // For loading state

  final List<Widget> _screens = [
    const HomeScreen(), // Replace with actual Home widget if needed
    const MyCardScreen(),
    const StatisticsScreen(),
    const MyAccountScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when screen is loaded
  }

  Future<void> _fetchUserData() async {
    const String apiUrl = 'https://ptechapp-5ab6d15ba23c.herokuapp.com/users';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          user = User.fromJson(data); // Assign the fetched user data
          isLoading = false; // Stop loading
        });
      } else {
        // Handle API error
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle network or other errors
      print('Error fetching user data: $e');
    }
  }

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
        preferredSize: const Size.fromHeight(70.0), // Set custom height
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0,
          automaticallyImplyLeading: false,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 6.0), // Adjust vertical padding
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 24, // Adjust size
                      backgroundImage: AssetImage('assets/P_TECH.png'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back,",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          GlobalVariables.firstName
                              .toString(), // Static placeholder for the user, // Static placeholder for the user
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.notifications,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading spinner
          : Padding(
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
                            balance: "12970", // Dynamic balance from API
                            lastDigits: "2468",
                            width: screenWidth * 0.75,
                            imagePath: 'assets/card.png',
                          ),
                          const SizedBox(width: 16),
                          CreditCardWidget(
                            cardName: "Y-Card",
                            balance: "\$2,664.63", // Mock balance
                            lastDigits: "7897",
                            width: screenWidth * 0.75,
                            imagePath: 'assets/card.png',
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
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                      children: [
                        ServiceTile(
                          icon: Icons.send,
                          title: "Send",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentScreen(),
                              ),
                            );
                          },
                        ),
                        ServiceTile(
                          icon: Icons.request_page,
                          title: "Request",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RequestMoneyScreen(), // Define RequestMoneyScreen here
                              ),
                            );
                          },
                        ),
                        ServiceTile(
                          icon: Icons.payment,
                          title: "Bills",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BillsPaymentScreen(), // Define RequestMoneyScreen here
                              ),
                            );
                          },
                        ),
                        ServiceTile(
                          icon: Icons.contact_mail,
                          title: "Contact",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactsScreen(), // Define RequestMoneyScreen here
                              ),
                            );
                          },
                        ),
                        ServiceTile(
                          icon: Icons.volunteer_activism,
                          title: "Donation",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DonationScreen(), // Define RequestMoneyScreen here
                              ),
                            );
                          },
                        ),
                        ServiceTile(
                          icon: Icons.account_balance_wallet,
                          title: "e-Wallet",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EWalletScreen(), // Define RequestMoneyScreen here
                              ),
                            );
                          },
                        ),
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
                            fontWeight: FontWeight.bold,
                          ),
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
                    // Mock transactions
                    const TransactionItem(
                      icon: Icons.swap_horiz,
                      title: 'Money Transfer',
                      subtitle: '4 Sep 2024 \n 12:32 AM',
                      amount: '\$300',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Outgoing Transactions",
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
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
                      amount: '- \$5.99',
                    ),
                    const TransactionItem(
                      icon: Icons.shopping_cart_sharp,
                      title: 'Amazon',
                      subtitle: '4 Sep 2024 \n 12:32 AM',
                      amount: '- \$12.99',
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
    );
  }
}
