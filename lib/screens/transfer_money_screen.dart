import 'package:flutter/material.dart';

import 'payment_confirmation_screen.dart'; // Import for date formatting

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String recipientNumber = '';
  String amount = '';
  String additionalDetails = '';
  String selectedPaymentType = 'Transfer Money';

  void _navigateToConfirmation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationScreen(
            recipient: recipientNumber,
            amount: amount,
            paymentType: selectedPaymentType,
            additionalDetails: additionalDetails,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00BBFF), // Dark Purple
                Color(0xFF374577), // Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPaymentOptions(),
            const SizedBox(height: 20),
            _buildPaymentTypeDropdown(),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    _buildRecipientField(),
                    const SizedBox(height: 20),
                    _buildAmountField(),
                    const SizedBox(height: 20),
                    _buildAdditionalDetailsField(),
                    const SizedBox(height: 30),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildOptionButton('Transfer Money', Icons.send),
        _buildOptionButton('Pay Bills', Icons.receipt_long),
        _buildOptionButton('Mobile Recharge', Icons.phone_android),
        _buildOptionButton('Internet Bills', Icons.wifi),
      ],
    );
  }

  Widget _buildOptionButton(String label, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF374577),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedPaymentType = label;
        });
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
    );
  }

  Widget _buildPaymentTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedPaymentType,
      items: <String>[
        'Transfer Money',
        'Pay Bills',
        'Mobile Recharge',
        'Internet Bills'
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentType = newValue!;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Select Payment Type',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildRecipientField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Recipient Number",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter recipient number';
        }
        return null;
      },
      onSaved: (value) => recipientNumber = value!,
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Amount",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter amount';
        }
        return null;
      },
      onSaved: (value) => amount = value!,
    );
  }

  Widget _buildAdditionalDetailsField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Additional Details",
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onSaved: (value) => additionalDetails = value!,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF374577),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: () => _navigateToConfirmation(context),
          child: const Text('Submit'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF374577),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: () {
            _formKey.currentState!.reset();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
