import 'dart:math';

import 'package:drug_management/home_page/beautiful_circle_box.dart';
import 'package:drug_management/iwant_meph.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_button/info_button_wrapper.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.sp});

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
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
    daysUntilParty = max(daysUntilParty, 0);

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
                            style: const TextStyle(
                                  fontSize: 16)),
                          Text(
                              "${sp.getString("lastUseDate") ?? "Not specified"}",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
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
