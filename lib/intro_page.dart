import 'package:drug_management/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyIntroPage extends StatefulWidget {
  const MyIntroPage({super.key});

  @override
  State<MyIntroPage> createState() => _MyIntroPageState();
}

class _MyIntroPageState extends State<MyIntroPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSetupCompleted() {
      MySharedPreferences.instance.setString(
          "lastUseDate",
          DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate.toUtc()));
      MySharedPreferences.instance.setBoolean("isSetupCompleted", true);
      Navigator.pop(context);
      Navigator.pushNamed(context, "/");
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
            GestureDetector(
                onTap: () => {_selectDate(context)},
                child: Text("${selectedDate.toLocal()}".split(' ')[0])),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => onSetupCompleted(),
              child: Text('Let\'s go'),
            ),
          ],
        ),
      ),
    );
  }
}
