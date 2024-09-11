import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ServiceTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color.fromARGB(255, 68, 18, 78)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
