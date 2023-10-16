import 'package:drug_management/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PartyPage extends StatelessWidget {
  const PartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome to the party")),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                          width: 300.0,
                          child: TextField(
                              decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'What will you use?',
                          ))),
                      // Text(
                      //     "Glad to see that you handled the 90-day-sobriety challenge")
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              MySharedPreferences.instance.setString(
                                  "lastUseDate",
                                  DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()));
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
                            },
                            child: Text(
                              'USEEE',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10))),
                          ))
                    ]))));
  }
}
