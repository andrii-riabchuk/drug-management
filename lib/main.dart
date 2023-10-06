import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class CircleRenameMe extends StatelessWidget {
  const CircleRenameMe(
      {super.key, required this.days, required this.message, this.color});

  final int days;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${days} Days",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message)
          ]),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color ?? Colors.grey),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        children: [
          CircleRenameMe(
              days: 10,
              message: "Until Party",
              color: Color.fromARGB(255, 255, 223, 245)),
          CircleRenameMe(days: 10, message: "Sober", color: Color(0xFFe0f2f1)),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('I WANT METH'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.days,
    required this.message,
  });

  final int days;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Text(
                "$days",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(message)
            ])));
  }
}
