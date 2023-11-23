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

  String searchStr = "";

  void setSearchStr(String str) {
    searchStr = str;
    notifyListeners();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    var rowsState = context.watch<HistoryRowsState>();

    filterRows(String filterStr) {
      rowsState.setSearchStr(filterStr);
    }

    setSearch(bool v) {
      if (!v) filterRows("");
      setState(() => isSearch = v);
    }

    var appBar = AppBar();
    if (!isSearch) {
      appBar = AppBar(title: const Text("History"), actions: [
        IconButton(onPressed: () => setSearch(true), icon: Icon(Icons.search))
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
                          onPressed: () => setSearch(false),
                          icon: Icon(Icons.clear))))));
    }

    return Scaffold(appBar: appBar, body: HistoryRows());
  }
}

class HistoryRows extends StatefulWidget {
  const HistoryRows({super.key});

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
            historyRows
                .where((element) =>
                    element.toString().toLowerCase().contains(filterStr))
                .forEach((r) => toShow.add(HistoryRow(r)));
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
