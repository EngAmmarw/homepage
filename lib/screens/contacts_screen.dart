import 'dart:convert'; // Add this import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class Contact {
  final String name;
  final String accountNumber;
  final String? imageUrl;
  bool isFavorite;

  Contact({
    required this.name,
    required this.accountNumber,
    this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      };

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json['name'],
        accountNumber: json['accountNumber'],
        imageUrl: json['imageUrl'],
        isFavorite: json['isFavorite'],
      );
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts(); // Load contacts when the screen is initialized
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactsString = prefs.getString('contacts');
    if (contactsString != null) {
      final List<dynamic> contactsJson = jsonDecode(contactsString);
      setState(() {
        _contacts = contactsJson.map((json) => Contact.fromJson(json)).toList();
        _filteredContacts = _contacts;
      });
    }
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> contactsJson =
        _contacts.map((contact) => contact.toJson()).toList();
    await prefs.setString('contacts', jsonEncode(contactsJson));
  }

  @override
  Widget build(BuildContext context) {
    List<Contact> displayedContacts =
        _filteredContacts.isEmpty ? _contacts : _filteredContacts;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contacts',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E), // Dark Purple
                Color(0xFF374577), // Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts',
                prefixIcon: Icon(Icons.search, color: const Color(0xFF44124E)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  _filteredContacts = _contacts
                      .where((contact) =>
                          contact.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          contact.accountNumber.contains(query))
                      .toList();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showAddContactDialog(context);
                  },
                  child: Container(
                    width: 150, // Smaller width
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF44124E),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                        const SizedBox(width: 5), // Smaller spacing
                        const Text(
                          'Add Contact',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14), // Smaller font
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: displayedContacts.isEmpty &&
                    _searchController.text.isNotEmpty
                ? Center(
                    child: Text(
                      'No contacts found',
                      style: TextStyle(
                          fontSize: 18, color: const Color(0xFF374577)),
                    ),
                  )
                : ListView.builder(
                    itemCount: displayedContacts.length,
                    itemBuilder: (context, index) {
                      final contact = displayedContacts[index];
                      return Dismissible(
                        key: Key(contact.name),
                        onDismissed: (direction) {
                          setState(() {
                            _contacts.removeAt(index);
                            _saveContacts(); // Save contacts after deletion
                          });
                        },
                        background: Container(color: Colors.red),
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: contact.imageUrl != null
                                  ? NetworkImage(contact.imageUrl!)
                                  : null,
                              child: contact.imageUrl == null
                                  ? Text(contact.name[0],
                                      style: TextStyle(color: Colors.white))
                                  : null,
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.accountNumber),
                            trailing: IconButton(
                              icon: Icon(
                                contact.isFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFFBC02D),
                              ),
                              onPressed: () {
                                setState(() {
                                  contact.toggleFavorite();
                                  _saveContacts(); // Save contacts after toggling favorite
                                });
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContactDetailsScreen(contact: contact),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritesScreen(contacts: _contacts),
            ),
          );
        },
        backgroundColor: const Color(0xFF44124E),
        child: Icon(
          Icons.star,
          color: Color(0xFFFBC02D),
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    String newName = '';
    String newAccountNumber = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  newName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Account Number'),
                onChanged: (value) {
                  newAccountNumber = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              onPressed: () {
                if (newName.isNotEmpty && newAccountNumber.isNotEmpty) {
                  setState(() {
                    _contacts.add(Contact(
                      name: newName,
                      accountNumber: newAccountNumber,
                    ));
                    _saveContacts(); // Save contacts after adding
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF374577),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailsScreen({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          contact.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E), //
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
            CircleAvatar(
              radius: 50,
              backgroundImage: contact.imageUrl != null
                  ? NetworkImage(contact.imageUrl!)
                  : null,
              child: contact.imageUrl == null
                  ? Text(contact.name[0], style: TextStyle(fontSize: 50))
                  : null,
            ),
            SizedBox(height: 20),
            Text(
              'Account Number: ${contact.accountNumber}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showTransferDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF44124E),
              ),
              child: Text(
                'Transfer Money',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transfer Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle amount input
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Note (optional)'),
                onChanged: (value) {
                  // Handle note input
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Transfer',
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle money transfer logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 193, 193, 193),
              ),
            ),
          ],
        );
      },
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final List<Contact> contacts;

  FavoritesScreen({required this.contacts});

  @override
  Widget build(BuildContext context) {
    final favoriteContacts =
        contacts.where((contact) => contact.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Contacts',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF44124E), // Dark Purple
                Color(0xFF374577), // Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteContacts.length,
        itemBuilder: (context, index) {
          final contact = favoriteContacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: contact.imageUrl != null
                  ? NetworkImage(contact.imageUrl!)
                  : null,
              child: contact.imageUrl == null
                  ? Text(contact.name[0], style: TextStyle(color: Colors.white))
                  : null,
            ),
            title: Text(contact.name),
            subtitle: Text(contact.accountNumber),
            trailing: IconButton(
              icon: Icon(
                Icons.star,
                color: Colors.yellow[700],
              ),
              onPressed: () {
                // Optionally handle removal from favorites
              },
            ),
          );
        },
      ),
    );
  }
}
