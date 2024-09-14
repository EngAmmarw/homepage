import 'package:flutter/material.dart';
import '../widgets/notification_item.dart';
import '../widgets/section_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New activity section
              SectionTitle(title: 'New activity'),
              NotificationItem(
                logo: 'assets/bank_transfer.png', // Path to bank transfer logo
                company: 'Bank Transfer',
                description:
                    'You received \$1500 from John Doe. Check your account for details.',
                time: '12 min ago',
              ),
              NotificationItem(
                logo:
                    'assets/security_alert.png', // Path to security alert logo
                company: 'Security Alert',
                description:
                    'Suspicious login detected. Please verify if this was you.',
                time: '47 min ago',
              ),
              SizedBox(height: 16.0),

              // Transactions section
              SectionTitle(title: 'Recent Transactions', action: 'See all'),
              NotificationItem(
                logo: 'assets/grocery.png', // Path to grocery logo
                company: 'Grocery Store',
                description:
                    'You spent \$50 at Grocery Store. View details in your transaction history.',
                time: '1 hr ago',
              ),
              NotificationItem(
                logo:
                    'assets/online_purchase.png', // Path to online shopping logo
                company: 'Online Shopping',
                description:
                    'Your purchase of \$200 was successful. Thank you for shopping with us!',
                time: '3 hrs ago',
              ),
              SizedBox(height: 16.0),

              // Loan and Card section
              SectionTitle(title: 'Loans & Cards', action: 'See all'),
              NotificationItem(
                logo: 'assets/loan.png', // Path to loan logo
                company: 'Personal Loan',
                description:
                    'Your personal loan application has been approved. Check your loan status.',
                time: '4 hrs ago',
              ),
              NotificationItem(
                logo: 'assets/credit_card.png', // Path to credit card logo
                company: 'Credit Card',
                description:
                    'Your credit card bill is due in 5 days. Don’t forget to make your payment.',
                time: '6 hrs ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
