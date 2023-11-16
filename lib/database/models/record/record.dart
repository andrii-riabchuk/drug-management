import 'package:drug_management/utils/date_time_utils.dart';

// ignore: constant_identifier_names
const String CREATE_RECORDS_TABLE =
    'CREATE TABLE Records(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dateTime DATETIME, substance TEXT, amount TEXT, description TEXT)';

class Record {
  DateTime dateTime;
  String substance;
  String? amount;
  String? description;

  Record.literally(this.dateTime, this.substance,
      {this.amount, this.description});

  Record(Map<String, dynamic> map)
      : dateTime = DateTime.parse(map['dateTime']),
        substance = map['substance'] as String,
        amount = map['amount'] as String?,
        description = map['description'] as String?;

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toString(),
      'substance': substance,
      'amount': amount,
      'description': description
    };
  }

  @override
  String toString() {
    var dateTimeFormatted = dateTime.formatDateTimeShort();
    return "$dateTimeFormatted | $substance${amount != null ? " $amount" : ""}";
  }
}
