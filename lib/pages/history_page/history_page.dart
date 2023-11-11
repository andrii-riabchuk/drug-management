import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/another_history_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drug_management/database/models.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key, required this.sp});
  // : historyService = HistoryService(sp: sp);

  final SharedPreferences sp;
  // final HistoryService historyService;

  @override
  Widget build(BuildContext context) {
    List<HistoryEntry> toShow = [];

    // historyService.getRecords().forEach((record) {
    //   toShow.add(HistoryEntry(record));
    // });

    return Scaffold(
        appBar: AppBar(title: const Text("History")),
        // body: Column(mainAxisSize: MainAxisSize.max, children: toShow),
        body: FutureBuilderExample());
  }
}

class HistoryEntry extends StatelessWidget {
  const HistoryEntry(this.record, {super.key});

  final RecordView record;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Padding(
                  padding: EdgeInsets.all(10), child: Text(record.body))))
    ]);
  }
}

class RecordView {
  final int id;
  final String body;

  RecordView(Record record)
      : id = record.id,
        body = record.body;

  const RecordView.fromString(this.body) : id = 1;
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({super.key});

  @override
  State<FutureBuilderExample> createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  static Future<List<Record>> getData() {
    var historyService = new AnotherHistoryService();
    return historyService.getRecords();
  }

  final Future<List<Record>> _retrieve = getData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Record>>(
        future: _retrieve,
        builder: (BuildContext context, AsyncSnapshot<List<Record>> snapshot) {
          List<HistoryEntry> toShow = [];
          if (!snapshot.hasData) {
            toShow = [HistoryEntry(RecordView.fromString("Loading..."))];
          } else if (snapshot.data == null || snapshot.data?.isEmpty != false) {
            toShow = [HistoryEntry(RecordView.fromString("No records"))];
          } else {
            snapshot.data?.forEach((r) {
              toShow.add(HistoryEntry(RecordView(r)));
            });
          }
          return Column(mainAxisSize: MainAxisSize.max, children: toShow);
        });
  }
}
