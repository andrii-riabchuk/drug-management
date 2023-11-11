import 'dart:developer';

import 'package:drug_management/database/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> init() async {
    final Future<Database> openDb = openDatabase(
      join(await getDatabasesPath(), 'drug_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Records(id INTEGER PRIMARY KEY, body TEXT)',
        );
      },
      version: 1,
    );

    final db = await openDb;
    var exampleRecord = Record(1, "speedball (AMF 1g + Heroin 0.3g)");

    await db.insert(
      'records',
      exampleRecord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return openDb;
  }

  static Future<List<Record>> retrieveRecords(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('records');

    return List.generate(maps.length, (i) {
      return Record(
        maps[i]['id'] as int,
        maps[i]['body'] as String,
      );
    });
  }
}
