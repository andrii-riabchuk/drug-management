import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/database/database.dart';
import 'package:drug_management/database/models.dart';
import 'package:drug_management/pages/history_page/history_service.dart';
import 'package:drug_management/shared_pref.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyIntroPage extends StatefulWidget {
  const MyIntroPage({super.key});

  @override
  State<MyIntroPage> createState() => _MyIntroPageState();
}

class _MyIntroPageState extends State<MyIntroPage> {
  DateTime selectedDate = DateTime.now();
  final substanceController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    substanceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DB.open();

    void onSetupCompleted() {
      var lastUseDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate.toUtc());

      MySharedPreferences.instance
          .setString(StorageKeys.LastUseDate, lastUseDate);
      MySharedPreferences.instance
          .setBoolean(StorageKeys.IsSetupCompleted, true);

      var record = Record.from(lastUseDate, substanceController.text);
      HistoryService().insertRecord(record);

      context.redirectTo(Routes.Home);
    }

    void skip() {
      MySharedPreferences.instance
          .setBoolean(StorageKeys.IsSetupCompleted, true);
      context.redirectTo(Routes.Home);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stay safe"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Last time used?",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Date: "),
              OutlinedButton(
                  onPressed: () => {_selectDate(context)},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Text(selectedDate.toLocal().toString().split(' ')[0]))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Substance: "),
              SizedBox(
                  height: 30,
                  width: 100,
                  child: TextField(
                    controller: substanceController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      border: OutlineInputBorder(),
                      hintText: '?',
                    ),
                    style: TextStyle(fontSize: 14),
                  ))
            ]),
            SizedBox(height: 10),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
              onPressed: () => onSetupCompleted(),
              child: Text('Let\'s go'),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: () => skip(),
              child: Text('skip'),
            ),
          ],
        ),
      ),
    );
  }
}
