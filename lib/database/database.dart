import 'dart:developer' as dev;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> open() async {
    var path = await getDatabasesPath();
    dev.log("PATH:$path");
    final Future<Database> openDb = openDatabase(
      join(await getDatabasesPath(), 'drug_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Records(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, body TEXT)',
        );
      },
      version: 1,
    );

    return openDb;
  }
}
