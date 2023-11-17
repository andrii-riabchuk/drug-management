import 'package:drug_management/database/models/record/record.dart';
import 'package:sqflite/sqflite.dart';

// ignore: constant_identifier_names
const String RECORDS_TABLE = "RECORDS";

extension Records on Database {
  insertSampleRecord() async {
    var exampleRecord =
        Record.literally(DateTime.now(), "speedball (AMF 1g + Heroin 0.3g)");

    await insert(
      RECORDS_TABLE,
      exampleRecord.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insertRecord(Record record) async {
    await insert(RECORDS_TABLE, record.toMap());
  }

  updateRecord(Record record) async {
    if (record.id != null) {
      await update(RECORDS_TABLE, record.toMap(), where: "id = ${record.id}");
    }
  }

  Future<List<Record>> retrieveRecords() async {
    final List<Map<String, dynamic>> maps =
        await query(RECORDS_TABLE, orderBy: "dateTime desc");

    return List.generate(maps.length, (i) {
      return Record(maps[i]);
    });
  }
}
