import 'package:flutter/material.dart';
import 'package:note_app1/models/note.dart';
import 'package:note_app1/widget/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.spacing, required this.notes});

  final double spacing;
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      itemCount: notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 15,
        childAspectRatio: 3 / 3,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true, note: notes[index]);
      },
    );
  }
}
