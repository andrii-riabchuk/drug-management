const String CREATE_NOTES_TABLE =
    'CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dateTime DATETIME NOT NULL, body TEXT)';

class Note {
  DateTime dateTime;
  String body;

  Note.literally(this.dateTime, this.body);
  Note(Map<String, dynamic> map)
      : dateTime = DateTime.parse(map['dateTime']),
        body = map['body'] as String;

  Map<String, dynamic> toMap() {
    return {'dateTime': dateTime.toString(), 'body': body};
  }
}
