import 'package:flutter/material.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedCurrency = 'EGP';
  final _amountController = TextEditingController();
  bool _isProcessing = false;

  // Mock function to show donation confirmation
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Donation Successful'),
          content: Text(
              'You have donated ${_amountController.text} $_selectedCurrency to $_selectedCategory. Thank you for your generosity!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Make a Donation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E),
                Color(0xFF374577)
              ], // User preferred colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color(0xFFEFF9F0)
            ], // Softer colors
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Icon(
                          Icons.volunteer_activism,
                          color: Color(0xFF44124E),
                          size: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select a Cause',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF374577),
                                ),
                              ),
                              const SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                value: _selectedCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCategory = newValue;
                                  });
                                },
                                items: _buildCategoryItems(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                ),
                                validator: (value) => value == null
                                    ? 'Please select a category'
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Enter Donation Amount',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF374577),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      controller: _amountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Amount',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            double.tryParse(value) == null ||
                                            double.tryParse(value)! <= 0) {
                                          return 'Enter a valid amount';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedCurrency,
                                      onChanged: (String? newCurrency) {
                                        setState(() {
                                          _selectedCurrency = newCurrency;
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'EGP',
                                          child: Text('EGP'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'USD',
                                          child: Text('USD'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'EUR',
                                          child: Text('EUR'),
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Quick Donate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF374577),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                children: [
                                  _buildQuickDonateButton('\$10'),
                                  _buildQuickDonateButton('\$50'),
                                  _buildQuickDonateButton('\$100'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _isProcessing
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isProcessing = true;
                                          });
                                          Future.delayed(
                                            const Duration(seconds: 2),
                                            () {
                                              setState(() {
                                                _isProcessing = false;
                                              });
                                              _showSuccessDialog();
                                            },
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF44124E),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        elevation: 5,
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Donate Now',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      )),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCategoryItems() {
    return [
      DropdownMenuItem(
        value: 'Education',
        child: Row(
          children: const [
            Icon(Icons.school, color: Colors.blue),
            SizedBox(width: 8),
            Text('Education'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Health',
        child: Row(
          children: const [
            Icon(Icons.local_hospital, color: Colors.red),
            SizedBox(width: 8),
            Text('Health'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Environment',
        child: Row(
          children: const [
            Icon(Icons.eco, color: Colors.green),
            SizedBox(width: 8),
            Text('Environment'),
          ],
        ),
      ),
    ];
  }

  Widget _buildQuickDonateButton(String amount) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _amountController.text = amount.replaceAll('\$', '');
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF44124E),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        amount,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
