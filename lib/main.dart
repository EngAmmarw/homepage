import 'package:flutter/material.dart';
import 'package:homepage/screens/congrats_screen.dart';
import 'package:homepage/screens/transaction_page.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBankers App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(
            255, 68, 18, 78), // Set the primary color to the deep purple color
      ),
      home: const Splashscreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/con': (context) => const CongratsScreen(),
        '/transaction': (context) => TransactionPage(),
      },
    );
  }
}
