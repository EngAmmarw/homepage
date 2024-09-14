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
        title: const Text('Donation'),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade300, Colors.purple.shade700],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Icon(
                  Icons.volunteer_activism,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Category:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter Donation Amount:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    double.tryParse(value) == null ||
                                    double.tryParse(value)! <= 0) {
                                  return 'Enter a valid amount (min \$1)';
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Quick Donate:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _amountController.text = '10';
                            }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade300,
                            ),
                            child: const Text('\$10'),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _amountController.text = '50';
                            }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade300,
                            ),
                            child: const Text('\$50'),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _amountController.text = '100';
                            }),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade300,
                            ),
                            child: const Text('\$100'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _isProcessing
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  Future.delayed(const Duration(seconds: 2),
                                      () {
                                    setState(() {
                                      _isProcessing = false;
                                    });
                                    _showSuccessDialog();
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 209, 209, 209),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              child: const Text('Donate Now'),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
}
