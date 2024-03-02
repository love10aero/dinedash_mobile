import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'globals.dart'; // Assuming 'server_ip' and 'selectedCompanyId' are defined here

class DashboardOpeningCard extends StatefulWidget {
  const DashboardOpeningCard({super.key});

  @override
  _DashboardOpeningCardState createState() => _DashboardOpeningCardState();
}

class _DashboardOpeningCardState extends State<DashboardOpeningCard> {
  int openingsNumber = 0;
  late Dio dio;

  @override
  void initState() {
    super.initState();

    
    dio = Dio();
    dio.interceptors.add(CookieManager(CookieJar()));

    _fetchOpenings();
  }

  _fetchOpenings() async {
    try {
      print('hola');
      print('$serverIp/api/schedules/monthdays?companyId=1');
      final response = await dio.get('$serverIp/api/schedules/monthdays?companyId=1'); // Adjust companyId as needed
      print(response.data);
      final data = response.data;
      setState(() {
        openingsNumber = data.length; // Ensure your API returns a list
      });
    } catch (error) {
      if (error is DioError) {
        print("DioError received: ${error.response?.data}, status code: ${error.response?.statusCode}");
        // Aquí puedes usar error.response?.data o error.response?.statusCode según necesites
      } else {
        print("Unknown error: $error");
      }
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('$openingsNumber', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
            subtitle: const Text('Days Open This Month', textAlign: TextAlign.center),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.schedule),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Schedule page'),
                    ),
                  ],
                ),
                onPressed: () {
                  // Navigate to schedule page
                  // For example:
                  // Navigator.pushNamed(context, '/schedule');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
