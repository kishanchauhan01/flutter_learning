import 'package:flutter/material.dart';
// import 'package:notes_app/pages/home_page.dart';
// import 'package:notes_app/pages/login_page.dart';
// import 'package:notes_app/pages/login_page.dart';
import 'package:notes_app/pages/splsh_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      home: SplshScreen(),
    );
  }
}
