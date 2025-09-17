import 'package:flutter/material.dart';
import 'package:note_app1/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// Get a reference to the Firestore database
final db = FirebaseFirestore.instance;

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes];

  Future<void> addNoteToDb(
    String title,
    String content,
    List<String> tags,
  ) async {
    try {
      // Create a Map to represent the note data
      final note = <String, dynamic>{
        "title": title,
        "content": content,
        "tags": tags,

        "timestamp":
            FieldValue.serverTimestamp(), // Adds a server-side timestamp
      };

      // Add a new document with a generated ID to the 'notes' collection
      await db.collection("notes").add(note);
      print("Note added successfully!");
    } catch (e) {
      print("Error adding note: $e");
    }
  }

  // Function to get all notes for the current user ONCE.
  Future<QuerySnapshot<Map<String, dynamic>>> getNotes() async {
    // Fetch the documents using get()
    // This returns a Future<QuerySnapshot>
    return db.collection("notes").get();
  }

  void addNote(Note note) {
    _notes.add(note);
    addNoteToDb(note.title!, note.content!, note.tags!);
    notifyListeners();
  }
}
