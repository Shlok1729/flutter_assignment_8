import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const BrainBlitzApp());
}

class BrainBlitzApp extends StatelessWidget {
  const BrainBlitzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Blitz 🧠',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Roboto'),
      home: const LoginScreen(),
    );
  }
}
