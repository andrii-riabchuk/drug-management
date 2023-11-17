import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models/record/record.dart';
import 'package:drug_management/database/models/record/records_crud.dart';

class HistoryService {
  Future<Record?> getLastUseDate() async {
    final db = await DB.open();
    var records = await db.retrieveRecords();
    if (records.isEmpty) return null;

    return records[0];
  }

  Future<List<Record>> getRecords() async {
    final db = await DB.open();
    return db.retrieveRecords();
  }

  insertRecord(Record record) async {
    final db = await DB.open();
    db.insertRecord(record);
  }

  updateRecord(Record record) async {
    final db = await DB.open();
    db.updateRecord(record);
  }
}

// class RecordView {
//   final String body;

//   RecordView(Record record) : body = record.toString();

//   const RecordView.fromString(this.body);
// }
