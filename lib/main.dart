import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App UI',
      theme: AppTheme.themeData, // Use a separate theme file
      home: const HomeScreen(),
    );
  }
}
