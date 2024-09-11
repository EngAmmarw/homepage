import 'package:flutter/material.dart';

class TransactionDetails extends StatelessWidget {
  final String transactionId = "12345";
  final String amount = "45.8";
  final String date = "8/9/2024";
  final String type = "Online Purchase";
  final String payee = "Amazon";
  final String note = "Purchased electronics";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transaction ID: $transactionId'),
          Text('Amount: $amount'),
          Text('Date: $date'),
          Text('Type: $type'),
          Text('Payee: $payee'),
          Text('Note: $note'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Close')),
              ElevatedButton(onPressed: () {}, child: Text('Edit')),
            ],
          ),
        ],
      ),
    );
  }
}
