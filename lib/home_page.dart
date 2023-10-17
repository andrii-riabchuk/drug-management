import 'package:drug_management/home_page/beautiful_circle_box.dart';
import 'package:drug_management/iwant_meph.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:drug_management/utils/date_time_utils.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_button/info_button_wrapper.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.sp});

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {

    bool isSetupCompleted = sp.getBoolIfExist("isSetupCompleted");
    String? lastUseDateString = sp.getString("lastUseDate");
    if (!isSetupCompleted || lastUseDateString == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => context.redirectToSetup());
      return Scaffold();
    }

    final TODAY = DateTime.now();

    DateTime lastUseDate = DateTimeUtils.parseUtcFormatted(lastUseDateString);
    DateTime partyDate = lastUseDate.plus(days: 3);

    int daysSober = DateTimeUtils.daysBetween(lastUseDate, TODAY);
    int daysUntilParty = DateTimeUtils.daysBetween(TODAY, partyDate);

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
