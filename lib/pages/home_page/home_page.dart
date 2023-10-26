import 'package:drug_management/buttons/history_button.dart';
import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/home_page/beautiful_circle_box.dart';
import 'package:drug_management/pages/party/iwant_meph.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:drug_management/utils/date_time_utils.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../buttons/info_button_wrapper.dart';

class MyHomePage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const int PARTY_PERIOD = 90;

  const MyHomePage({super.key, required this.sp});

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    bool isSetupCompleted = sp.getBoolIfExist("isSetupCompleted");
    String? lastUseDateString = sp.getString("lastUseDate");
    if (!isSetupCompleted || lastUseDateString == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => context.redirectTo(Routes.setup));
      return Scaffold();
    }

    final TODAY = DateTime.now();

    DateTime lastUseDate = DateTimeUtils.parseUtcFormatted(lastUseDateString);
    DateTime partyDate = lastUseDate.plus(days: PARTY_PERIOD);

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
                    DateInfo(lastUseDate, partyDate),
                    Container(
                        child: Column(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Column(children: [
                            UntilPartyBox(daysUntilParty: daysUntilParty),
                            SoberBox(daysSober: daysSober)
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

class SoberBox extends StatelessWidget {
  const SoberBox({
    super.key,
    required this.daysSober,
  });

  final int daysSober;

  @override
  Widget build(BuildContext context) {
    return WithInfoButton(
        dialogSettings: const InfoDialogSettings(
            title: "Why shouldn't give up", message: Messages.whyStay),
        child: BeautifulCircleBox(
            color: Color(0xFFe0f2f1), child: Counter(daysSober, "Sober")));
  }
}

class UntilPartyBox extends StatelessWidget {
  const UntilPartyBox({
    super.key,
    required this.daysUntilParty,
  });

  final int daysUntilParty;

  @override
  Widget build(BuildContext context) {
    return WithInfoButton(
        dialogSettings: const InfoDialogSettings(
            title: "Why wait", message: Messages.whyWait),
        child: BeautifulCircleBox(
            color: Color.fromARGB(255, 255, 223, 245),
            child: Counter(daysUntilParty, "Until Party")));
  }
}

class DateInfo extends StatelessWidget {
  const DateInfo(this.lastUseDate, this.partyDate, {super.key});

  final DateTime lastUseDate;
  final DateTime partyDate;

  @override
  Widget build(BuildContext context) {
    var lastUseDateFormatted = lastUseDate.toLocal().formatDateWithWords();
    var partyDateFormatted = partyDate.toLocal().formatDateWithWords();

    var labelStyle = const TextStyle(fontSize: 16);
    var dateStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Stack(children: [
                    Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Last use Date: ", style: labelStyle),
                            Text(lastUseDateFormatted, style: dateStyle)
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Party Date: ", style: labelStyle),
                            Text(partyDateFormatted, style: dateStyle)
                          ])
                    ]),
                    Positioned(right: 0, child: HistoryButton())
                  ]))
                ])));
  }
}
