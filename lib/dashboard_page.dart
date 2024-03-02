import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Assuming 'server_ip' is defined elsewhere in your Flutter project
import 'globals.dart';
import 'dash_opening_card.dart'; // Make sure to create this file

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String company = '';

  @override
  void initState() {
    super.initState();
    _fetchCompany();
  }

  _fetchCompany() async {
    try {
      final response = await http.get(Uri.parse('$serverIp/api/company'));
      final data = json.decode(response.body);
      setState(() {
        company = data['name'];
      });
    } catch (error) {
      print(error);
      // Implement error handling, e.g., using a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard $company'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: const <Widget>[
          DashboardOpeningCard(),
          // Add other dashboard cards here
        ],
      ),
    );
  }
}
