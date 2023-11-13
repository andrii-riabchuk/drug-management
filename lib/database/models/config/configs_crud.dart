import 'package:drug_management/database/models/config/config.dart';
import 'package:sqflite/sqflite.dart';

// ignore: constant_identifier_names
const String CONFIGS_TABLE = "Configs";

extension Configs on Database {
  insertConfig(Config record) async {
    await insert(CONFIGS_TABLE, record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Config>> getConfigs() async {
    final List<Map<String, dynamic>> maps = await query(CONFIGS_TABLE);

    return maps.map((mp) => Config(mp)).toList();
  }
}
