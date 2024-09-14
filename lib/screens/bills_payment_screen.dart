import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class BillsPaymentScreen extends StatefulWidget {
  const BillsPaymentScreen({super.key});

  @override
  _BillsPaymentScreenState createState() => _BillsPaymentScreenState();
}

class _BillsPaymentScreenState extends State<BillsPaymentScreen> {
  String? _selectedCategory;
  String? _selectedDate;
  String? _selectedCurrency = 'EGP'; // Default currency selection
  bool _isProcessing = false;
  final _amountController = TextEditingController();

  // Mock function to show payment confirmation
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your bill has been paid successfully!'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bills Payment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 68, 18, 78),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Category:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Electricity',
                    child: Row(
                      children: const [
                        Icon(Icons.flash_on, color: Colors.yellow),
                        SizedBox(width: 10),
                        Text('Electricity'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Water',
                    child: Row(
                      children: const [
                        Icon(Icons.water, color: Colors.blue),
                        SizedBox(width: 10),
                        Text('Water'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Internet',
                    child: Row(
                      children: const [
                        Icon(Icons.wifi, color: Colors.green),
                        SizedBox(width: 10),
                        Text('Internet'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Gas',
                    child: Row(
                      children: const [
                        Icon(Icons.local_gas_station, color: Colors.red),
                        SizedBox(width: 10),
                        Text('Gas'),
                      ],
                    ),
                  ),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Amount:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCurrency = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(value: 'EGP', child: Text('EGP')),
                        DropdownMenuItem(value: 'USD', child: Text('USD')),
                        DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Due Date:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _selectedDate),
                      decoration: InputDecoration(
                        hintText: 'Pick a due date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _isProcessing
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        if (_amountController.text.isNotEmpty &&
                            _selectedCategory != null &&
                            _selectedDate != null) {
                          setState(() {
                            _isProcessing = true;
                          });
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              _isProcessing = false;
                            });
                            _showSuccessDialog();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill in all fields')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 68, 18, 78),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30), // Increase padding
                        textStyle: const TextStyle(
                          fontSize: 15, // Increase font size
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // More rounded corners
                        ),
                        elevation: 5, // Add shadow for a modern look
                      ),
                      child: const Text('Pay Now'),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Payment History:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: const [
                  ListTile(
                    leading: Icon(Icons.flash_on, color: Colors.yellow),
                    title: Text('Electricity Bill - \$120'),
                    subtitle: Text('Paid on 10 Sep 2024'),
                    trailing: Text('Completed',
                        style: TextStyle(color: Colors.green)),
                  ),
                  ListTile(
                    leading: Icon(Icons.water, color: Colors.blue),
                    title: Text('Water Bill - \$40'),
                    subtitle: Text('Paid on 7 Sep 2024'),
                    trailing: Text('Completed',
                        style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
