import 'package:drug_management/custom_widgets/buttons/history_button.dart';
import 'package:drug_management/custom_widgets/buttons/info_button_wrapper.dart';
import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/custom_widgets/beautiful_circle_box.dart';
import 'package:drug_management/database/application_data.dart';
import 'package:drug_management/pages/party/i_want_it.dart';
import 'package:drug_management/utils/date_time_utils.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> loadData() async {
    return ApplicationData.loadHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          }
          if (snapshot.hasError) {
            return Text('Just hanging around..');
          } else {
            return Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting data...'),
                  )
                ])));
          }
        });
  }
}

class MyHomePage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const int PARTY_PERIOD = 90;

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!ApplicationData.setupCompleted) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => context.redirectTo(Routes.Setup));
      return Scaffold();
    }

    // ignore: non_constant_identifier_names
    final TODAY = DateTime.now();

    DateTime? lastUseDate = ApplicationData.lastUseRecord?.dateTime;
    DateTime partyDate = DateTime.now();
    int? daysSober;
    int daysUntilParty;

    if (lastUseDate != null) {
      partyDate = lastUseDate.plus(days: PARTY_PERIOD);
      daysSober = DateTimeUtils.daysBetween(lastUseDate, TODAY);
    }
    daysUntilParty = DateTimeUtils.daysBetween(TODAY, partyDate);

    bool showRecordForEditing =
        lastUseDate != null && TODAY.difference(lastUseDate).inHours < 24;
    bool isAllowedToUse = daysUntilParty == 0;

    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateInfo(lastUseDate, partyDate),
            Column(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Column(children: [
                    UntilPartyBox(daysUntilParty: daysUntilParty),
                    SoberBox(daysSober: daysSober)
                  ])),
              IWantIt(
                isAllowedToUse: isAllowedToUse,
                showRecordForEditing: showRecordForEditing,
                initialCount: ApplicationData.iWantItCount,
              ),
            ])
          ]),
    ));
  }
}

class SoberBox extends StatelessWidget {
  const SoberBox({
    super.key,
    required this.daysSober,
  });

  final int? daysSober;

  @override
  Widget build(BuildContext context) {
    return WithInfoButton(
        dialogSettings: const InfoDialogSettings(
            title: "Why shouldn't give up", message: Messages.WhyStay),
        child: BeautifulCircleBox(
            color: Color(0xFFe0f2f1),
            child: Counter(daysSober ?? 999999, "Sober")));
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
            title: "Why wait", message: Messages.WhyWait),
        child: BeautifulCircleBox(
            color: Color.fromARGB(255, 255, 223, 245),
            child: Counter(daysUntilParty, "Until Party")));
  }
}

class DateInfo extends StatelessWidget {
  const DateInfo(this.lastUseDate, this.partyDate, {super.key});

  final DateTime? lastUseDate;
  final DateTime partyDate;

  @override
  Widget build(BuildContext context) {
    var lastUseDateFormatted = "never";
    if (lastUseDate != null) {
      lastUseDateFormatted =
          (lastUseDate ?? DateTime.now()).toLocal().formatDateWithWords();
    }

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
