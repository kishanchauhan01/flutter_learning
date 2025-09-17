import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplshScreen extends StatefulWidget {
  const SplshScreen({super.key});

  @override
  State<SplshScreen> createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isLoggedin = prefs.getBool("isLogin") ?? false;

      if (isLoggedin) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, weight: 50.0),
              Text(
                "Hello !",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
