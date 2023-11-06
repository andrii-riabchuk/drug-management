import 'package:dropdown_button2/dropdown_button2.dart';
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
  String unit = "g";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    substanceCtrl.dispose();
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
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextInput('What will you use?', substanceCtrl),
                      SizedBox(height: 6),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 82.0),
                                child: TextInput(
                                  'Amount',
                                  amountCtrl,
                                  sufix: unit,
                                )),
                            UnitDropDown(
                                amountUnitCtrl,
                                (e) => {
                                      setState(() {
                                        unit = e;
                                      })
                                    }),
                          ]),
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

class TextInput extends StatelessWidget {
  const TextInput(this.name, this.controller, {super.key, this.sufix});

  final TextEditingController controller;
  final String name;
  final String? sufix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            label: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Text(name),
                  ),
                  WidgetSpan(
                    child: Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            suffixText: sufix,
            border: OutlineInputBorder(),
          ),
          style: TextStyle(fontSize: 13),
        ));
  }
}

class UnitDropDown extends StatelessWidget {
  const UnitDropDown(this.controller, this.callback, {super.key});
  final Function(String) callback;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropDown(controller: controller, callback: callback);
  }
}

class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.callback, required this.controller});
  final TextEditingController controller;
  final Function(String) callback;

  @override
  State<DropDown> createState() => _DropdownButtonExampleState();
}

List<String> possibleUnits = <String>['g', 'mg', 'µg'];

class _DropdownButtonExampleState extends State<DropDown> {
  String? dropdownValue = possibleUnits.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.controller.text = value;
          widget.callback(value);
        });
      },
      menuItemStyleData: MenuItemStyleData(height: 30),
      items: possibleUnits.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
