import 'package:flutter/material.dart';

class FilterTransactions extends StatefulWidget {
  const FilterTransactions({super.key});

  @override
  _FilterTransactionsState createState() => _FilterTransactionsState();
}

class _FilterTransactionsState extends State<FilterTransactions> {
  bool isChecked = false;
  RangeValues _currentRangeValues = const RangeValues(10, 100);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date Range:'),
          const SizedBox(height: 10),
          // You can use DatePicker here for actual implementation
          ElevatedButton(
              onPressed: () {}, child: const Text('Select Date Range')),

          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              const Text('Transaction Type'),
            ],
          ),

          const SizedBox(height: 20),
          const Text('Amount Range:'),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000,
            divisions: 10,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Apply')),
              ElevatedButton(onPressed: () {}, child: const Text('Reset')),
            ],
          ),
        ],
      ),
    );
  }
}
