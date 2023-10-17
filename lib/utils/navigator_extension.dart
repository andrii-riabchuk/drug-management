import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  redirectTo(String route) {
    Navigator.pop(this);
    Navigator.pushNamed(this, route);
  }

  redirectToSetup() {
    redirectTo("/setup");
  }

  addNewPage(route, {bool removeOther = false}) {
    if (removeOther) {
      Navigator.of(this).pushNamedAndRemoveUntil(route, (_) => false);
    } else {
      Navigator.pushNamed(this, route);
    }
  }

  pop() {
    Navigator.of(this).pop();
  }
}
