import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models/config/config.dart';
import 'package:drug_management/database/models/config/configs_crud.dart';

class ConfigService {
  Future<Config?> getConfig(String key) async {
    var configs = await getConfigs();
    for (var config in configs) {
      if (config.key == key) return config;
    }

    return null;
  }

  Future<List<Config>> getConfigs() async {
    final db = await DB.open();
    return db.getConfigs();
  }

  insert(String key, String value) async {
    final db = await DB.open();
    db.insertConfig(Config.literally(key, value));
  }
}
