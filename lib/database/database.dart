import 'package:drug_management/database/models/config/config.dart';
import 'package:drug_management/database/models/record/record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static const String databaseName = 'drug_database.db';
  static const List<String> tables = [
    CREATE_RECORDS_TABLE,
    CREATE_CONFIGS_TABLE
  ];

  static Future<Database> open() async {
    var path = join(await getDatabasesPath(), databaseName);

    final Future<Database> openDb = openDatabase(
      path,
      onCreate: (db, version) {
        for (var createTableQuery in tables) {
          db.execute(createTableQuery);
        }
      },
      version: 1,
    );

    return openDb;
  }

  static ensureDeleted() async {
    var path = join(await getDatabasesPath(), databaseName);
    if (await databaseExists(path)) {
      deleteDatabase(path);
    }
  }
}
