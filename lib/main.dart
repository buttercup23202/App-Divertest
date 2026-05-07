import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const DivergentTestApp());
}

class DivergentTestApp extends StatelessWidget {
  const DivergentTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Mundo de Divergente',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const WelcomeScreen(),
    );
  }
}