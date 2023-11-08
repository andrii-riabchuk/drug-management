import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

List<String> possibleUnits = <String>['g', 'mg', 'µg'];

class UnitDropDown extends StatelessWidget {
  const UnitDropDown(this.controller, this.callback, {super.key});
  final Function(String) callback;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropDown(controller: controller, callback: callback);
  }
}

class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.callback, required this.controller});
  final TextEditingController controller;
  final Function(String) callback;

  @override
  State<DropDown> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropDown> {
  String? dropdownValue = possibleUnits[1];

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.controller.text = value;
          widget.callback(value);
        });
      },
      menuItemStyleData: MenuItemStyleData(height: 30),
      items: possibleUnits.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
