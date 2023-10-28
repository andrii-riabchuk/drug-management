import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key, required this.sp})
      : historyService = HistoryService(sp: sp);

  final SharedPreferences sp;
  final HistoryService historyService;

  @override
  Widget build(BuildContext context) {
    List<HistoryEntry> toShow = [];

    historyService.getRecords().forEach((record) {
      toShow.add(HistoryEntry(record));
    });

    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Column(mainAxisSize: MainAxisSize.max, children: toShow),
    );
  }
}

class HistoryEntry extends StatelessWidget {
  const HistoryEntry(this.record, {super.key});

  final Record record;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Padding(
                  padding: EdgeInsets.all(10), child: Text(record.record))))
    ]);
  }
}
