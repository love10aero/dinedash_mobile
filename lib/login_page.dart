import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importa Flutter Secure Storage
import 'dashboard_page.dart'; // Adjust the import path based on your file structure

// Replace with your server IP or domain
const String serverIp = 'https://0765l069-4000.uks1.devtunnels.ms';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage(); // Crea una instancia de FlutterSecureStorage

  Future<void> _handleLoginSubmit() async {
    final response = await http.post(
      Uri.parse('$serverIp/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Assuming 'token' is returned upon successful login
      final responseData = json.decode(response.body);
      final token = responseData['token']; // Assuming the token is in the response
      
      // Save the token using Flutter Secure Storage
      await storage.write(key: 'authToken', value: token);

      // Navigate to the DashboardPage
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));

    } else {
      // Navigate to the DashboardPage
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
      // Show error message
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${responseData['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Tu logo aquí
              Text('DineDash', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              const Text('Welcome back! Log in to your account.', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLoginSubmit,
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
