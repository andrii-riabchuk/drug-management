import 'dart:developer' as dev;
import 'package:drug_management/database/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String databaseName = 'drug_database.db';

  static ensureDeleted() async {
    var path = join(await getDatabasesPath(), databaseName);
    if (await databaseExists(path)) {
      deleteDatabase(path);
    }
  }

  static Future<Database> open() async {
    var path = join(await getDatabasesPath(), databaseName);
    dev.log("PATH:$path");

    // ensureDeleted(path);
    final Future<Database> openDb = openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(CREATE_RECORDS_TABLE);
      },
      version: 1,
    );

    return openDb;
  }
}
