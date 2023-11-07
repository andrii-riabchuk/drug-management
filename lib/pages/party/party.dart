import 'package:drug_management/custom_widgets/text_input.dart';
import 'package:drug_management/custom_widgets/unit_dropdown.dart';
import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:drug_management/utils/date_time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({super.key});

  @override
  State<PartyPage> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  final substanceCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final amountUnitCtrl = TextEditingController(text: possibleUnits.first);

  String unit = possibleUnits.first;
  updateUnitState(String val) {
    setState(() {
      unit = val;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    substanceCtrl.dispose();
    amountCtrl.dispose();
    amountUnitCtrl.dispose();
    super.dispose();
  }

  void recordUsage(BuildContext context) {
    var storageKey = StorageKeys.LastUseDate;
    var now = DateTimeUtils.utcNowFormatted();
    MySharedPreferences.instance.setString(storageKey, now);

    var amountFormatted = "${amountCtrl.text} ${amountUnitCtrl.text}";
    var record = Record(now, substanceCtrl.text, amount: amountFormatted);
    SharedPreferences.getInstance()
        .then((sp) => HistoryService.addToHistory(sp, record));

    context.addNewPage(Routes.Home, removeOther: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("You got it")),
        body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Questionnaire(substanceCtrl, amountCtrl, amountUnitCtrl,
                          unit, updateUnitState),
                      UseButton(() => {recordUsage(context)})
                    ]))));
  }
}

class Questionnaire extends StatelessWidget {
  const Questionnaire(this.substanceCtrl, this.amountCtrl, this.amountUnitCtrl,
      this.unit, this.updateUnitState,
      {super.key});

  final TextEditingController substanceCtrl, amountCtrl, amountUnitCtrl;
  final String unit;
  final Function(String) updateUnitState;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextInput('What will you use?', substanceCtrl),
      SizedBox(height: 6),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.only(left: 82.0),
            child: TextInput(
              'Amount',
              amountCtrl,
              sufix: unit,
            )),
        UnitDropDown(amountUnitCtrl, updateUnitState),
      ])
    ]);
  }
}

class UseButton extends StatelessWidget {
  const UseButton(
    this.callback, {
    super.key,
  });

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10))),
          onPressed: () => callback(),
          child: Text(
            'USE',
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
