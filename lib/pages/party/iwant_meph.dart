import 'dart:async';

import 'dart:developer' as developer;

import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  MyAppState({required this.current});

  int current = 0;
  Timer? timer;

  void wantMeph() {
    current = current + 1;

    notifyListeners();
  }
}

class IWantMeph extends StatelessWidget {
  const IWantMeph({super.key, required this.sp, required this.isAllowedToUse});

  final SharedPreferences sp;
  final bool isAllowedToUse;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // ← 2

    return Column(children: [
      GestureDetector(
          onPanDown: (details) {
            appState.timer =
                Timer.periodic(Duration(milliseconds: 2000), (timer) {
              context.addNewPage(Routes.secret);
            });
          },
          onPanCancel: () {
            appState.timer?.cancel();
          },
          child: ElevatedButton(
              onPressed: () {
                appState.wantMeph();
                sp.setInt("wantMeph", appState.current);
                if (isAllowedToUse) {
                  context.addNewPage(Routes.party);
                }
              },
              child: Text('I WANT MEPH'))),
      Text("Wanted already ${appState.current} times")
    ]);
  }
}
