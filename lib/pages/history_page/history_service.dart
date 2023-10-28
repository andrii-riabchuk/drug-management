import 'package:drug_management/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Record {
  Record(this.record);

  String record = "Missing_Info";
}

class HistoryService {
  const HistoryService({required this.sp});

  final SharedPreferences sp;

  List<Record> getRecords() {
    List<Record> result = [];

    var fromStorage = sp.getStringList(StorageKeys.History);

    //add mock data
    if (fromStorage == null) {
      var history = ["2023-09-14 | weed", "2023-08-29 | alcohol"];
      sp.setStringList("history", history);
      fromStorage = history;
    }

    result = fromStorage.map((str) => Record(str)).toList();

    return result;
  }
}
