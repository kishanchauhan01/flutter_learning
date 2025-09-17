import 'dart:async';

import 'package:database_demo/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? _db;
  Future<Database> getDb() async {
    if (_db != null) {
      return _db!;
    }

    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'database_demo.db');

    _db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return _db!;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contact_master (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mobile TEXT
      )''');
  }

  Future<int> insertRecord(String name, String mobile) async {
    final dbClient = await getDb();

    final val = {'name': name, 'mobile': mobile};

    return dbClient.insert('contact_master', val);
  }

  Future<List<ContactModel>> getData() async {
    final dbClient = await getDb();

    List<ContactModel> contactList = [];

    final coursr = await dbClient.query('contact_master');

    for (int i = 0; i < corser.length; i++) {
      String name = corser[i]['name'].toString();
      String mobile = corser[i]['mobile'].toString();

      ContactModel model = ContactModel(name, mobile);

      contactList.add(model);
    }

    return contactList;
  }
}
