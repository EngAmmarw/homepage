import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import '../controllars/payment_controller.dart';
import '../models/payment_request.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final String recipient;
  final String amount;
  final String paymentType;
  final String additionalDetails;

  const PaymentConfirmationScreen({
    super.key,
    required this.recipient,
    required this.amount,
    required this.paymentType,
    required this.additionalDetails,
  });

  void _confirmPayment(BuildContext context) {
    // Create a PaymentRequest object with the necessary details
    final paymentRequest = PaymentRequest(
      receiverAccountNumber: recipient, // Recipient account number
      senderAccountNumber: '100000062', // Hard-coded sender account number
      paymentDate:
          DateFormat('yyyy-MM-dd').format(DateTime.now()), // Current date
      paymentAmount: int.parse(amount), // Payment amount
      paymentType: paymentType, // Payment type
    );

    // Instantiate the PaymentController and make the payment request
    final paymentController = PaymentController(context: context);
    paymentController.makePayment(paymentRequest);

    // Navigate to CongratsScreen after a successful payment
    Navigator.pushNamed(context, '/congrats');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Confirmation",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 68, 18, 78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPaymentDetails(),
            const SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow("Recipient:", recipient),
        const SizedBox(height: 10),
        _buildDetailRow("Payment Amount:", amount),
        const SizedBox(height: 10),
        _buildDetailRow("Payment Method:", paymentType),
        const SizedBox(height: 10),
        _buildDetailRow("Additional Details:", additionalDetails),
        const SizedBox(height: 10),
        _buildDetailRow(
            "Date:", DateFormat('yyyy-MM-dd').format(DateTime.now())),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 68, 18, 78),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: () {
            _confirmPayment(context); // Call the payment confirmation method
          },
          child: const Text('Confirm'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 68, 18, 78),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: () {
            Navigator.pop(context); // Handle cancel action
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
