import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homepage/generated/l10n.dart';
import 'package:homepage/screens/congrats_screen.dart';
import 'package:homepage/screens/transaction_page.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'ByteBankers App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(
            255, 68, 18, 78), // Set the primary color to the deep purple color
      ),
      home: const Splashscreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/congrats': (context) => const CongratsScreen(),
        '/transaction': (context) => const TransactionPage(),
      },
    );
  }
}
