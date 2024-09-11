import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart'; // Assuming this is your custom widget
import '../widgets/transaction_details.dart';
import '../widgets/filter_transactions.dart'; // Assuming this is your custom widget
// Assuming this is your custom widget

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showOutgoingOnly = false;
  bool _showIncomingOnly = false;

  List<Map<String, dynamic>> transactions = [
    {
      'icon': Icons.apple,
      'title': 'Apple Store',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '- \$5.99'
    },
    {
      'icon': Icons.music_note,
      'title': 'Spotify',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '- \$12.99'
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Money Transfer',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '\$300'
    },
    {
      'icon': Icons.shopping_cart,
      'title': 'Grocery',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '- \$88'
    },
    {
      'icon': Icons.movie,
      'title': 'Netflix',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '- \$5.99'
    },
    {
      'icon': Icons.shopping_cart_sharp,
      'title': 'Amazon',
      'subtitle': '4 Sep 2024 \n 12:32 AM',
      'amount': '- \$12.99'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTransactions = transactions
        .where((transaction) => transaction['title']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();

    List<Map<String, dynamic>> outgoingTransactions = filteredTransactions
        .where((transaction) => transaction['amount'].startsWith('-'))
        .toList();

    List<Map<String, dynamic>> incomingTransactions = filteredTransactions
        .where((transaction) => !transaction['amount'].startsWith('-'))
        .toList();

    List<Map<String, dynamic>> displayedTransactions = _showOutgoingOnly
        ? outgoingTransactions
        : _showIncomingOnly
            ? incomingTransactions
            : filteredTransactions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: const Color.fromRGBO(79, 61, 87, 1)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon:
                Icon(Icons.refresh, color: const Color.fromRGBO(79, 61, 87, 1)),
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
                _showOutgoingOnly = false;
                _showIncomingOnly = false;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Transactions',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterTransactions(); // Show filter options
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showOutgoingOnly = true;
                    _showIncomingOnly = false;
                  });
                },
                child: Text(
                  "Outgoing Transactions",
                  style: TextStyle(
                      color: _showOutgoingOnly ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showOutgoingOnly = false;
                    _showIncomingOnly = true;
                  });
                },
                child: Text(
                  "Incoming Transactions",
                  style: TextStyle(
                      color: _showIncomingOnly ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: displayedTransactions
                  .map((transaction) => TransactionItem(
                        icon: transaction['icon'],
                        title: transaction['title'],
                        subtitle: transaction['subtitle'],
                        amount: transaction['amount'],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
