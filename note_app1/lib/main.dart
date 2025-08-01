import 'package:flutter/material.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/pages/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: primary,
            fontSize: 32.0,
            fontFamily: 'Fredoka',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
