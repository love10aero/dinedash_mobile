import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Replace with your server IP or domain
const String serverIp = 'http://your_server_ip_or_domain';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      // You might want to save the token using Flutter Secure Storage
      widget.onLoginSuccess();
    } else {
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
              // Your logo here
              Text('We are Login', style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 8),
              Text('Welcome back! Log in to your account.', textAlign: TextAlign.center),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLoginSubmit,
                child: Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
