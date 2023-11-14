import 'package:drug_management/database/models/note/note.dart';
import 'package:sqflite/sqflite.dart';

// ignore: constant_identifier_names
const String NOTES_TABLE = "Notes";

extension Notes on Database {
  insertNote(Note record) async {
    await insert(NOTES_TABLE, record.toMap());
  }

  Future<List<Note>> getNotes() async {
    final List<Map<String, dynamic>> maps = await query(NOTES_TABLE);

    return maps.map((mp) => Note(mp)).toList();
  }
}
