// lib/app/data/providers/database_provider.dart
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note_model.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database? _database;
  
  factory DatabaseProvider() => _instance;
  
  DatabaseProvider._internal();

  /// Get database instance (singleton pattern)
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'notes_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create database tables
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database schema upgrades here if needed
    if (oldVersion < newVersion) {
      // Add migration logic for future versions
    }
  }

  /// Insert a new note
  Future<int> insertNote(NoteModel note) async {
    final db = await database;
    return await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get all notes
  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      orderBy: 'updated_at DESC',
    );

    return List.generate(maps.length, (i) {
      return NoteModel.fromMap(maps[i]);
    });
  }

  /// Get note by ID
  Future<NoteModel?> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NoteModel.fromMap(maps.first);
    }
    return null;
  }

  /// Update a note
  Future<int> updateNote(NoteModel note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Delete a note
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all notes (useful for testing)
  Future<int> deleteAllNotes() async {
    final db = await database;
    return await db.delete('notes');
  }

  /// Get notes count
  Future<int> getNotesCount() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM notes'),
    );
    return count ?? 0;
  }

  /// Close database connection
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}