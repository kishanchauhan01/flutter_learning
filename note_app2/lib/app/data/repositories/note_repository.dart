// lib/app/data/repositories/note_repository.dart
import 'package:note_app2/app/data/providers/database_provider.dart';

import '../models/note_model.dart';

class NoteRepository {
  final DatabaseProvider _databaseProvider;

  NoteRepository({DatabaseProvider? databaseProvider})
      : _databaseProvider = databaseProvider ?? DatabaseProvider();

  /// Create a new note
  Future<int> createNote({
    required String title,
    required String description,
  }) async {
    final now = DateTime.now();
    final note = NoteModel(
      title: title,
      description: description,
      createdAt: now,
      updatedAt: now,
    );

    return await _databaseProvider.insertNote(note);
  }

  /// Get all notes
  Future<List<NoteModel>> getAllNotes() async {
    try {
      return await _databaseProvider.getAllNotes();
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  /// Get note by ID
  Future<NoteModel?> getNoteById(int id) async {
    try {
      return await _databaseProvider.getNoteById(id);
    } catch (e) {
      throw Exception('Failed to fetch note: $e');
    }
  }

  /// Update an existing note
  Future<bool> updateNote({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      final existingNote = await _databaseProvider.getNoteById(id);
      if (existingNote == null) {
        throw Exception('Note not found');
      }

      final updatedNote = existingNote.copyWith(
        title: title,
        description: description,
        updatedAt: DateTime.now(),
      );

      final rowsAffected = await _databaseProvider.updateNote(updatedNote);
      return rowsAffected > 0;
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  /// Delete a note
  Future<bool> deleteNote(int id) async {
    try {
      final rowsAffected = await _databaseProvider.deleteNote(id);
      return rowsAffected > 0;
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  /// Get total notes count
  Future<int> getNotesCount() async {
    try {
      return await _databaseProvider.getNotesCount();
    } catch (e) {
      throw Exception('Failed to get notes count: $e');
    }
  }
}
