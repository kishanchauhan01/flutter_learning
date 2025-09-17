import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Contact info")),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Name"),
                    label: Text("Enter your name"),
                  ),
                ),
                SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(
                    hint: Text("Mobile number"),
                    label: Text("Enter your mobile number"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
