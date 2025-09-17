import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes App",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(201, 255, 193, 7),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Icon(Icons.notes),
        // ],
      ),
      body: NotesScreen(),
    );
  }
}
