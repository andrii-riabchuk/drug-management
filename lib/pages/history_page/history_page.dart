import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:flutter/material.dart';
import 'package:drug_management/database/models.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("History")), body: HistoryRows());
  }
}

class HistoryRows extends StatefulWidget {
  const HistoryRows({super.key});

  @override
  State<HistoryRows> createState() => _HistoryRowsState();
}

class _HistoryRowsState extends State<HistoryRows> {
  static Future<List<Record>> getData() {
    var historyService = HistoryService();
    return historyService.getRecords();
  }

  final Future<List<Record>> _retrieve = getData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Record>>(
        future: _retrieve,
        builder: (BuildContext context, AsyncSnapshot<List<Record>> snapshot) {
          List<HistoryRow> toShow = [];
          if (!snapshot.hasData) {
            toShow = [HistoryRow(RecordView.fromString("Loading..."))];
          } else if (snapshot.data == null || snapshot.data?.isEmpty != false) {
            toShow = [HistoryRow(RecordView.fromString("No records"))];
          } else {
            snapshot.data?.forEach((r) {
              toShow.add(HistoryRow(RecordView(r)));
            });
          }
          return Column(mainAxisSize: MainAxisSize.max, children: toShow);
        });
  }
}

class HistoryRow extends StatelessWidget {
  const HistoryRow(this.record, {super.key});

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
