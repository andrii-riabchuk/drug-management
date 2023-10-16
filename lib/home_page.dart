import 'dart:math';

import 'package:drug_management/home_page/beautiful_circle_box.dart';
import 'package:drug_management/iwant_meph.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_button/info_button_wrapper.dart';

extension Storage on SharedPreferences {
  bool getBoolIfExist(String key) {
    return getBool(key) ?? false;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.sp});

  final SharedPreferences sp;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var diff = (to.difference(from).inHours / 24).round();
    return max(diff, 0);
  }

  @override
  Widget build(BuildContext context) {
    redirectToSetup() {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/setup");
    }

    bool isSetupCompleted = sp.getBoolIfExist("isSetupCompleted");
    String? lastUseDateString = sp.getString("lastUseDate");
    if (!isSetupCompleted || lastUseDateString == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => redirectToSetup());
      return Scaffold();
    }

    final TODAY = DateTime.now();
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    DateTime lastUseDate = dateFormat.parse(lastUseDateString, true).toLocal();
    DateTime partyDate = lastUseDate.add(const Duration(days: 3));

    int daysSober = daysBetween(lastUseDate, TODAY);
    int daysUntilParty = daysBetween(TODAY, partyDate);

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
                        child: Column(children: [
                          Text("Last Use Date:",
                              style: const TextStyle(fontSize: 16)),
                          Text("${lastUseDate.toLocal()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text("Party Date:",
                              style: const TextStyle(fontSize: 16)),
                          Text("${partyDate.toLocal()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ])),
                    Container(
                        child: Column(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Column(children: [
                            WithInfoButton(
                                dialogSettings: const InfoDialogSettings(
                                    title: "Why wait",
                                    message:
                                        "Because high would be fucking amazing"),
                                child: BeautifulCircleBox(
                                    color: Color.fromARGB(255, 255, 223, 245),
                                    child: Counter(
                                        daysUntilParty, "Until Party"))),
                            WithInfoButton(
                                dialogSettings: const InfoDialogSettings(
                                    title: "Why shouldn't give up",
                                    message: "Because you stay loser"),
                                child: BeautifulCircleBox(
                                    color: Color(0xFFe0f2f1),
                                    child: Counter(daysSober, "Sober")))
                          ])),
                      IWantMeph(
                        sp: sp,
                        isAllowedToUse: daysUntilParty == 0,
                      )
                    ]))
                  ]),
            )));
  }
}
