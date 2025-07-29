import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  String title;
  String description;
  String id;

  Note({required this.title, required this.description, required this.id});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'id': id,
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    title: json['title'],
    description: json['description'],
    id: json['id'],
  );

  static String notesToString(List<Note> notes) {
    //convert to json from list
    return jsonEncode(notes.map((note) => note.toJson()).toList());
  }

  static List<Note> stringToNotes(String notesString) {
    //convert to list from json
    List<dynamic> jsonList = jsonDecode(notesString);
    return jsonList.map((json) => Note.fromJson(json)).toList();
  }

  static Future<void> saveNotes(List<Note> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert List<Note> to string
    String noteString = notesToString(notes);

    // Save it
    await prefs.setString("notes_key", noteString);
  }

  static Future<List<Note>> loadNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? noteString = prefs.getString('notes_key');

    if (noteString != null) {
      return stringToNotes(noteString);
    } else {
      return []; //return an empty list if nothing is stored.
    }
  }

  static Future<void> clearNote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }


}
