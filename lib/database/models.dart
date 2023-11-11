// ignore: constant_identifier_names
import 'package:drug_management/utils/date_time_utils.dart';

const String CREATE_RECORDS_TABLE =
    'CREATE TABLE Records(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, dateTime DATETIME, substance TEXT, amount TEXT)';

class Record {
  DateTime dateTime;
  String substance;
  String? amount;

  Record(this.dateTime, this.substance, {this.amount});
  // : body = "$dateTime | $substance${amount != null ? " $amount" : ""}";

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toString(),
      'substance': substance,
      'amount': amount,
    };
  }

  @override
  String toString() {
    var dateTimeFormatted = dateTime.formatDateTimeShort();
    return "$dateTimeFormatted | $substance${amount != null ? " $amount" : ""}";
  }
}
