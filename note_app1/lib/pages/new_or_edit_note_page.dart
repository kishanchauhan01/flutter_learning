import 'package:flutter/material.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({super.key});

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
        actions: [
          
        ],
      ),
    );
  }
}