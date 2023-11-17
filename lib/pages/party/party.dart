import 'dart:developer';

import 'package:drug_management/custom_widgets/text_input.dart';
import 'package:drug_management/custom_widgets/unit_dropdown.dart';
import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/database/application_data.dart';
import 'package:drug_management/database/models/record/record.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({super.key});

  @override
  State<PartyPage> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  final substanceCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final amountUnitCtrl = TextEditingController(text: possibleUnits[1]);
  final tripDescriptionCtrl = TextEditingController();

  bool isEditingMode = false;
  Record? originalRecord;

  String unit = possibleUnits[1];
  updateUnitState(String val) {
    setState(() {
      unit = val;
      amountUnitCtrl.text = val;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    substanceCtrl.dispose();
    amountCtrl.dispose();
    amountUnitCtrl.dispose();
    tripDescriptionCtrl.dispose();
    super.dispose();
  }

  void recordUsage(BuildContext context) {
    var amountFormatted = "${amountCtrl.text} ${amountUnitCtrl.text}";
    log('record usage ' + originalRecord!.id.toString());
    if (isEditingMode) {
      var record = Record.literally(
          originalRecord!.dateTime, substanceCtrl.text,
          amount: amountFormatted,
          description: tripDescriptionCtrl.text,
          id: originalRecord!.id);
      HistoryService().updateRecord(record);
    } else {
      var record = Record.literally(DateTime.now().toUtc(), substanceCtrl.text,
          amount: amountFormatted, description: tripDescriptionCtrl.text);
      HistoryService().insertRecord(record);
    }

    context.open(Routes.Home, removeOther: true);
  }

  @override
  void initState() {
    super.initState();

    if (ApplicationData.lastUseRecord != null &&
        ApplicationData.lastUseRecord!.dateTime
                .difference(DateTime.now())
                .inHours <
            24) {
      log("too much again");
      isEditingMode = true;
      originalRecord = ApplicationData.lastUseRecord;
      substanceCtrl.text = originalRecord?.substance ?? "";
      if (originalRecord!.amount != null) {
        var amountComponents = originalRecord!.amount!.split(' ');
        amountCtrl.text =
            amountComponents.sublist(0, amountComponents.length - 1).join(' ');
        updateUnitState(amountComponents.reversed.first);
      }
      tripDescriptionCtrl.text = originalRecord?.description ?? "";
    }
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
                          tripDescriptionCtrl, unit, updateUnitState),
                      UseButton(() => {recordUsage(context)})
                    ]))));
  }
}

class Questionnaire extends StatelessWidget {
  const Questionnaire(this.substanceCtrl, this.amountCtrl, this.amountUnitCtrl,
      this.tripDescriptionCtrl, this.unit, this.updateUnitState,
      {super.key});

  final TextEditingController substanceCtrl,
      amountCtrl,
      amountUnitCtrl,
      tripDescriptionCtrl;
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
        UnitDropDown(
            amountUnitCtrl.text.isNotEmpty
                ? amountUnitCtrl.text
                : possibleUnits[1],
            amountUnitCtrl,
            updateUnitState),
      ]),
      Text("Trip description"),
      Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 28, 34, 44))),
          child: TextField(
            controller: tripDescriptionCtrl,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.text,
          ))
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
