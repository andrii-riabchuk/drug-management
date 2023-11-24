import 'package:drug_management/database/application_data.dart';
import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  redirectTo(String route) {
    Navigator.pop(this);
    Navigator.pushNamed(this, route);
  }

  open(route, {Object? argument, bool removeOther = false}) {
    if (removeOther) {
      Navigator.of(this)
          .pushNamedAndRemoveUntil(route, (_) => false, arguments: argument);
    } else {
      Navigator.pushNamed(this, route, arguments: argument).then((x) {
        if (x == 'reload') ApplicationData.homePageReload();
      });
    }
  }

  pop() {
    Navigator.of(this).pop();
  }
}
