import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text; // Text to display on the button
  final VoidCallback onPressed; // Function to call when the button is pressed
  final Color color; // Background color of the button
  final Color textColor; // Text color of the button
  final double fontSize; // Font size of the text
  final double borderRadius; // Border radius for rounded corners
  final double padding; // Padding inside the button

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color =
        const Color.fromARGB(255, 68, 18, 78), // Default color if not provided
    this.textColor = Colors.white, // Default text color
    this.fontSize = 16.0, // Default font size
    this.borderRadius = 8.0, // Default border radius
    this.padding = 16.0, // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Background color
        foregroundColor: textColor, // Text color
        padding: EdgeInsets.all(padding), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
      ),
      onPressed: onPressed, // Action to perform on press
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize), // Text style
      ),
    );
  }
}
