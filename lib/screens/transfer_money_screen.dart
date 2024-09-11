import 'package:flutter/material.dart';

class TransferMoneyScreen extends StatefulWidget {
  @override
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  String accountNumber = '';
  String transferAmount = '';
  String requesteeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Transfer Request",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
            margin: EdgeInsets.fromLTRB(16, 5, 0, 0),
            width: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Color.fromARGB(255, 68, 18, 78)),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                // Handle back action
              },
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Balance',
                style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 140, 136, 136)),
              ),
              SizedBox(height: 8),
              Text(
                "\$2,85,856.20",
                // Replace with dynamic balance data

                style: TextStyle(
                    fontSize: 32, color: const Color.fromARGB(255, 68, 18, 78)),
              ),
              SizedBox(height: 15),
              Text(
                "Please, enter the receiver's bank account number or phone number with the amount of transfer request in below field.",
                style: TextStyle(color: Color.fromARGB(255, 140, 136, 136)),
              ),
              SizedBox(height: 50),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Sender's Account No.",
                  suffixIcon: Icon(Icons.check_circle,
                      color: Color.fromARGB(255, 68, 18, 78)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account number';
                  }
                  return null;
                },
                onSaved: (value) => accountNumber = value!,
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount of Transfer Request',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter transfer amount';
                  }
                  return null;
                },
                onSaved: (value) => transferAmount = value!,
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Requestee's Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter requestee's name";
                  }
                  return null;
                },
                onSaved: (value) => requesteeName = value!,
              ),
              SizedBox(height: 100),
              Center(
                child: Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 68, 18, 78),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: const Size(0, 70.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
