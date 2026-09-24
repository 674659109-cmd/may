import 'package:flutter/material.dart';
import 'package:may/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusMeet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C52D4),
          primary: const Color(0xFF4C52D4),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFE),
      ),
      home: const LoginScreen(),
    );
  }
}
