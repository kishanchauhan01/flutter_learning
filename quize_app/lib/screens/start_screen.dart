import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app/screens/quize_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quize App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: Text("1", style: TextStyle(fontSize: 20)),
              title: Text("Rule1", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Text("2", style: TextStyle(fontSize: 20)),
              title: Text("Rule2", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Text("3", style: TextStyle(fontSize: 20)),
              title: Text("Rule3", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Text("4", style: TextStyle(fontSize: 20)),
              title: Text("Rule4", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Text("5", style: TextStyle(fontSize: 20)),
              title: Text("Rule5", style: TextStyle(fontSize: 20)),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.off(QuizeScreen());
              },
              child: Text("Go to Quize"),
            ),
          ],
        ),
      ),
    );
  }
}
