import 'package:drug_management/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircleRenameMe extends StatelessWidget {
  const CircleRenameMe(
      {super.key, required this.days, required this.message, this.color});

  final int days;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color ?? Colors.grey),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$days Days",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message)
          ]),
    );
  }
}

class MyAppState extends ChangeNotifier {
  MyAppState({required this.current});

  int current;

  void wantMeph() {
    current = current + 1;

    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.sp});

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // ← 2

    void func(bool isSetupCompleted) {
      if (!isSetupCompleted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/setup");
      }
    }

    MySharedPreferences.instance.getBooleanValue('isSetupCompleted').then(func);
    String lastUseDateFromStorage = sp.getString("lastUseDate") ?? "2023-10-05";
    DateTime lastUseDate = DateTime.parse(lastUseDateFromStorage);

    int daysSober = DateTime.now().difference(lastUseDate).inDays;
    int daysUntilParty = lastUseDate
        .add(const Duration(days: 90))
        .difference(DateTime.now())
        .inDays;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Text(
                            "Last Use Date: ${sp.getString("lastUseDate") ?? "Not specified"}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))),
                    Container(
                        child: Column(children: [
                      CircleRenameMe(
                          days: daysUntilParty,
                          message: "Until Party",
                          color: Color.fromARGB(255, 255, 223, 245)),
                      CircleRenameMe(
                          days: daysSober,
                          message: "Sober",
                          color: Color(0xFFe0f2f1)),
                      ElevatedButton(
                          onPressed: () {
                            appState.wantMeph();
                            sp.setInt("wantMeph", appState.current);
                          },
                          child: Text('I WANT MEPH')),
                      Text("Wanted already ${appState.current} times")
                    ]))
                  ]),
            )));
  }
}
