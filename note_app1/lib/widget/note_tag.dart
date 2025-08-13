import 'package:flutter/material.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color.fromARGB(186, 195, 158, 24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.only(right: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
