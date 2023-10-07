import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: <String, WidgetBuilder>{
//       '/': (context) => const MyIntroPage(),
//       '/app': (context) => MyApp()
//     },
//   ));
// }

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log("here should be sharedpreferences");
  log(prefs.getBool('isfirstRun').toString());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Launch Detection Demo',
    //if true return intro screen for first time Else go to login Screen
    initialRoute: "/app",
    routes: {
      '/': (context) => const MyIntroPage(),
      '/app': (context) => const MyApp()
    },
  ));
}

//------------------------------
class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}

class SharedPref extends StatefulWidget {
  const SharedPref({super.key});

  @override
  _SharedPrefState createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  bool isFirstLaunch = true;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Launch Detection Demo',
      //if true return intro screen for first time Else go to login Screen
      initialRoute: "/app",
      routes: {
        '/': (context) => const MyIntroPage(),
        '/app': (context) => const MyApp()
      },
    );
  }
}

class MyIntroPage extends StatefulWidget {
  const MyIntroPage({super.key});

  @override
  _MyIntroPageState createState() => _MyIntroPageState();
}

class _MyIntroPageState extends State<MyIntroPage> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutteriatko"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
                onTap: () => {_selectDate(context)},
                child: Text("${selectedDate.toLocal()}".split(' ')[0])),
            SizedBox(
              height: 20.0,
            ),
            // ElevatedButton(
            //   onPressed: () => _selectDate(context),
            //   child: Text('Select date'),
            // ),
            ElevatedButton(
              onPressed: () => {
                MySharedPreferences.instance
                    .setBooleanValue("setupCompleted", true),
                Navigator.pushNamed(context, '/app')
              },
              child: Text('Let\'s go'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    void doShit(bool setupCompleted) {
      if (!setupCompleted) {
        Navigator.pushNamed(context, '/');
      }
    }

    MySharedPreferences.instance.getBooleanValue("setupCompleted").then(doShit);

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
        body: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                CircleRenameMe(
                    days: 10,
                    message: "Until Party",
                    color: Color.fromARGB(255, 255, 223, 245)),
                CircleRenameMe(
                    days: 10, message: "Sober", color: Color(0xFFe0f2f1)),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('I WANT METH'),
                ),
              ],
            )));
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
