import 'package:drug_management/constants/constants.dart';
import 'package:drug_management/utils/navigator_extension.dart';
import 'package:flutter/material.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {context.open(Routes.History)},
        icon: Icon(Icons.book));
  }
}
