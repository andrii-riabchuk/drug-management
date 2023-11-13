import 'dart:async';

import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/database/application_data.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppState extends ChangeNotifier {
  MyAppState();

  int current = 0;
  Timer? timer;

  void wantMeph() {
    current = current + 1;
    ApplicationData.saveIwantItCount(current);

    notifyListeners();
  }
}

class IWantIt extends StatelessWidget {
  const IWantIt(
      {super.key, required this.isAllowedToUse, this.initialCount = 0});

  final bool isAllowedToUse;
  final int initialCount;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // ← 2
    if (appState.current == 0) appState.current = initialCount;

    return Column(children: [
      GestureDetector(
          onPanDown: (details) {
            appState.timer =
                Timer.periodic(Duration(milliseconds: 2000), (timer) {
              appState.timer?.cancel();
              context.addNewPage(Routes.Secret);
            });
          },
          onPanCancel: () {
            appState.timer?.cancel();
          },
          onPanEnd: (e) {
            appState.timer?.cancel();
          },
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 0, 149)),
              onPressed: () {
                appState.wantMeph();
                if (isAllowedToUse) {
                  context.addNewPage(Routes.Party);
                }
              },
              child: Text('I WANT IT'))),
      Text("Wanted already ${appState.current} times")
    ]);
  }
}
