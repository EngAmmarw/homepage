import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  final String cardName;
  final String balance;
  final String lastDigits;
  final double? width; // Add width parameter
  final double? height; // Height parameter
  final String imagePath; // Add imagePath parameter for background image

  const CreditCardWidget({
    super.key,
    required this.cardName,
    required this.balance,
    required this.lastDigits,
    this.width, // Initialize width
    this.height, // Initialize height
    required this.imagePath, // Initialize imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300, // Use provided width or default to 300
      height: height ?? 200, // Use provided height or default to 200

      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath), // Set the background image
          fit: BoxFit.cover, // Adjust the image to cover the container
        ),
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
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 248, 248, 248),
              ),
            ),
            const SizedBox(height: 8),
            const Spacer(),
            const Text(
              "Balance",
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 190, 188, 188)),
            ),
            Text(
              balance,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 248, 248, 248),
              ),
            ),
            const SizedBox(height: 8),
            const Spacer(),
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
