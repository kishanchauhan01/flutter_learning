import 'package:flutter/material.dart';
import 'package:note_app1/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.spacing});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      itemCount: 15,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 15,
        childAspectRatio: 3 / 3,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true);
      },
    );
  }
}
