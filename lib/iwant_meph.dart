import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  MyAppState({required this.current});

  int current;

  void wantMeph() {
    current = current + 1;

    notifyListeners();
  }
}

class IWantMeph extends StatelessWidget {
  const IWantMeph({
    super.key,
    required this.sp,
  });

  final SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // ← 2

    return Column(children: [
      ElevatedButton(
          onPressed: () {
            appState.wantMeph();
            sp.setInt("wantMeph", appState.current);
          },
          child: Text('I WANT MEPH')),
      Text("Wanted already ${appState.current} times")
    ]);
  }
}
