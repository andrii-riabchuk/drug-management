import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.sp});

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    List<HistoryEntry> toShow = [];

    var fromStorage = sp.getStringList("history");

    //add mock data
    if (fromStorage == null) {
      var history = ["2023-09-14 | weed", "2023-08-29 | alcohol"];
      sp.setStringList("history", history);
      fromStorage = history;
    }

    if (fromStorage != null) {
      fromStorage.forEach((record) {
        toShow.add(HistoryEntry(record));
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Column(mainAxisSize: MainAxisSize.max, children: toShow),
    );
  }
}

class HistoryEntry extends StatelessWidget {
  const HistoryEntry(this.record, {super.key});

  final String record;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Padding(padding: EdgeInsets.all(10), child: Text(record))))
    ]);
  }
}
