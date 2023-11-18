
import 'package:drug_management/database/models/record/record.dart';
import 'package:drug_management/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  RecordPage({super.key});

  Record? record;

  @override
  Widget build(BuildContext context) {
    record = ModalRoute.of(context)!.settings.arguments as Record;

    return Scaffold(
        appBar: AppBar(
            title: Text(record != null
                ? record!.dateTime.formatDateTimeShort()
                : "undefined")),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              RecordTable([
                "Date",
                "Substance",
                "Amount"
              ], [
                record!.dateTime.formatDateWithWords(),
                record!.substance,
                record?.amount ?? "not specified"
              ]),
              (() {
                if (record?.description == null || record!.description!.isEmpty) {
                  return Text('');
                }

                return Column(children: [
                  Text("Description"),
                  Container(
                      color: Colors.grey[200],
                      width: 300,
                      height: 400,
                      child: RichText(
                        text: TextSpan(
                          text: record!.description,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ))
                ]);
              }()),
            ])));
  }
}

class RecordTable extends StatelessWidget {
  RecordTable(this.headers, this.data, {super.key});

  final List<String> headers;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = [];
    for (int i = 0; i < headers.length; i++) {
      var row = [HeaderCell(headers[i]), Cell(Text(data[i]))];
      rows.add(TableRow(children: row));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        children: rows,
      ),
    );
  }
}

class HeaderCell extends StatelessWidget {
  HeaderCell(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Cell(Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold),
    ));
  }
}

class Cell extends StatelessWidget {
  Cell(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5), child: child);
  }
}
