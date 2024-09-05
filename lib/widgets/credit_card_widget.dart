import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardName;
  final String balance;
  final String lastDigits;
  final double? width; // Add width parameter

  const CreditCardWidget({
    super.key,
    required this.cardName,
    required this.balance,
    required this.lastDigits,
    this.width, // Initialize width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300, // Use provided width or default to 300
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              balance,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "**** $lastDigits",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
