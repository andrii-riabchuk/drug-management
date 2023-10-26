import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [Box(), Box(), Box()];

    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Column(children: list),
    );
  }
}

class Box extends StatelessWidget {
  const Box({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Text("HistoryRow"));
  }
}
