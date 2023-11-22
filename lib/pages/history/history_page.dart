import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history/history_service.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:drug_management/database/models/record/record.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class HistoryRowsState extends ChangeNotifier {
  HistoryRowsState();

  int updatedNtimes = 0;
  String searchStr = "";

  void setSearchStr(String str) {
    searchStr = str;
    updatedNtimes++;
    notifyListeners();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  bool isSearch = false;
  String searchStr = "";
  final searchStrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var rowsState = context.watch<HistoryRowsState>();

    filterRows(String filterStr) {
      rowsState.setSearchStr(filterStr);
    }

    // searchStrController.addListener(() {
    //   setState(() => searchStr = searchStrController.text);
    // });

    var appBar = AppBar();
    if (!isSearch) {
      appBar = AppBar(title: const Text("History"), actions: [
        IconButton(
            onPressed: () => {setState(() => isSearch = true)},
            icon: Icon(Icons.search))
      ]);
    } else {
      appBar = AppBar(
          // title: const Text("History"),
          title: TextField(
              autofocus: true,
              onChanged: (value) => {filterRows(value)},
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffix: Transform.translate(
                      offset: const Offset(0.0, 5.0),
                      child: IconButton(
                          onPressed: () => {setState(() => isSearch = false)},
                          icon: Icon(Icons.clear))))));
    }

    return Scaffold(appBar: appBar, body: HistoryRows(searchStr));
  }
}

class HistoryRows extends StatefulWidget {
  const HistoryRows(this.searchStr, {super.key});
  final String searchStr;

  @override
  State<HistoryRows> createState() => _HistoryRowsState();
}

class _HistoryRowsState extends State<HistoryRows> {
  Future<List<Record>> getData() {
    var historyService = HistoryService();
    return historyService.getRecords();
  }

  late final Future<List<Record>> _retrieve = getData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Record>>(
        future: _retrieve,
        builder: (BuildContext context, AsyncSnapshot<List<Record>> snapshot) {
          List<Widget> toShow = [];
          if (!snapshot.hasData) {
            toShow = [Text("Loading...")];
          } else if (snapshot.data != null) {
            var historyRows = snapshot.data!;
            var rowsState = context.watch<HistoryRowsState>();
            var filterStr = rowsState.searchStr.toLowerCase();
            historyRows = historyRows
                .where((element) =>
                    element.toString().toLowerCase().contains(filterStr))
                .toList();

            historyRows.forEach((r) => toShow.add(HistoryRow(r)));
            // toShow.add(Text('rowsState updated - ${rowsState.updatedNtimes}'));
            // toShow.add(Text('filter string - ${rowsState.searchStr}'));
          }

          if (toShow.isEmpty) {
            toShow.add(Text("No records"));
          }
          return Column(mainAxisSize: MainAxisSize.max, children: toShow);
        });
  }
}

class HistoryRow extends StatelessWidget {
  const HistoryRow(this.record, {super.key});

  final Record record;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () => {context.open(Routes.Record, argument: record)},
        child: Row(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(record.toString()))))
        ]));
  }
}
