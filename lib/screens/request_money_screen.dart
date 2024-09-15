import 'package:flutter/material.dart';

class RequestMoneyScreen extends StatefulWidget {
  @override
  _RequestMoneyScreenState createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  String selectedCurrency = 'USD'; // Default selected currency
  final List<String> currencies = ['USD', 'EUR', 'GBP']; // List of currencies

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0093C9), // Dark Purple
                Color(0xFF374577), // Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        title: const Text(
          'Request Money',
          style: TextStyle(
            color: Colors.white, // Title text color set to white
            fontWeight: FontWeight.bold, // Bold title text
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payer Input
            const Text("Payer", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                labelText: 'Enter Payer Name',
              ),
            ),
            const SizedBox(height: 16),

            // Email Address Input
            const Text("Email Address", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                labelText: 'Enter Email Address',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Description Input
            const Text("Description", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                labelText: 'Enter Description',
              ),
            ),
            const SizedBox(height: 16),

            // Monthly Due By Input
            const Text("Monthly Due By", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    // Calendar icon action
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                labelText: 'Select Date',
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),

            // Enter Amount and Currency Selector in a Rounded Bar
            const Text("Enter The Amount", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    10), // Rounded corners for the whole bar
                border: Border.all(color: Colors.grey), // Border color
              ),
              child: Row(
                children: [
                  // Currency Selector
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCurrency, // Currently selected currency
                      items: currencies.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCurrency =
                              newValue!; // Update selected currency
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                      width: 16), // Spacing between dropdown and amount field
                  // Vertical Divider
                  Container(
                    height: 24,
                    width: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  // Text Field for Entering Amount
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Request Money Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF374577), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Rounded corners for button
                  ),
                ),
                onPressed: () {
                  // Handle the request money action
                },
                child: const Text(
                  'Request Money',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
