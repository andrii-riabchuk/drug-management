import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:drug_management/utils/date_time_utils.dart';

class PartyPage extends StatelessWidget {
  const PartyPage({super.key});

  void recordUsage(BuildContext context) {
    var storageKey = StorageKeys.lastUseDate;
    var now = DateTimeUtils.utcNowFormatted();

    MySharedPreferences.instance.setString(storageKey, now);

    context.addNewPage(Routes.home, removeOther: true);
  }

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
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10))),
                            onPressed: () => recordUsage(context),
                            child: Text(
                              'USEEE',
                              style: TextStyle(fontSize: 20),
                            ),
                          ))
                    ]))));
  }
}
