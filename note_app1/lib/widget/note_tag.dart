import 'package:flutter/material.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({super.key, required this.label, this.onColsed});

  final String label;
  final VoidCallback? onColsed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color.fromARGB(186, 195, 158, 24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),

          if (onColsed != null) ...[
            SizedBox(width: 4),
            GestureDetector(
              onTap: onColsed,
              child: Icon(Icons.close, size: 18),
            ),
          ],
        ],
      ),
    );
  }
}
