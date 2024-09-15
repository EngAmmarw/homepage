import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap; // Callback for navigation

  const ServiceTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap, // Receive onTap function as parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger navigation when tapped
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container for icon background
              Container(
                padding: const EdgeInsets.all(12), // Padding around the icon
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF44124E), // baby blue
                      Color(0xFF374577), // Light Purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ), // Background color
                  shape: BoxShape.circle, // Circular shape for background
                ),
                child: Icon(icon, size: 25, color: Colors.white), // Icon color
              ),
              const SizedBox(height: 16),
              Text(title,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
