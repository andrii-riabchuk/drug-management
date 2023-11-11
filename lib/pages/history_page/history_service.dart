import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models.dart';
import 'package:drug_management/database/records.dart';

class HistoryService {
  Future<List<Record>> getRecords() async {
    final db = await DB.open();
    return db.retrieveRecords();
  }

  insertRecord(Record record) async {
    final db = await DB.open();
    db.insertRecord(record);
  }
}

class RecordView {
  final String body;

  RecordView(Record record) : body = record.body;

  const RecordView.fromString(this.body);
}
