import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models.dart';

class AnotherHistoryService {
  Future<List<Record>> getRecords() async {
    final db = await DB.init();
    return DB.retrieveRecords(db);
  }
}
