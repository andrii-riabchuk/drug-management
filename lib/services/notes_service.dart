import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models/note/note.dart';
import 'package:drug_management/database/models/note/notes_crud.dart';

class NotesService {
  Future<List<Note>> getNotes() async {
    final db = await DB.open();
    return db.getNotes();
  }

  Future<Note> addNote(String body) async {
    final db = await DB.open();
    final note = Note.literally(DateTime.now(), body);
    await db.insertNote(note);
    return note;
  }
}
