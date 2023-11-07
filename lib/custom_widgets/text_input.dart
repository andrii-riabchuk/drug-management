import 'package:flutter/material.dart';

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
