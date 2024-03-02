import 'package:flutter/material.dart';
import 'login_page.dart'; // Make sure the path matches your file structure

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _onLoginSuccess() {
    // Handle successful login, e.g., navigate to another page
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(onLoginSuccess: _onLoginSuccess),
    );
  }
}
