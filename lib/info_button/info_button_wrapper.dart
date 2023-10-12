import 'package:flutter/material.dart';

class InfoDialogSettings {
  const InfoDialogSettings({required this.title, required this.message});

  final String title;
  final String message;
}

class WithInfoButton extends StatelessWidget {
  const WithInfoButton(
      {super.key, required this.child, required this.dialogSettings});

  final Widget child;
  final InfoDialogSettings dialogSettings;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      child,
      IconButton(onPressed: () => showInfo(context), icon: Icon(Icons.info))
    ]);
  }

  void showInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(dialogSettings.title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(dialogSettings.message),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text('Вкурив'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
