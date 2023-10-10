import 'package:flutter/material.dart';

class CircleWithInfo extends StatelessWidget {
  const CircleWithInfo(
      {super.key,
      required this.days,
      required this.label,
      required this.color,
      required this.descriptionTitle,
      required this.description});

  final int days;
  final String label;
  final String descriptionTitle;
  final String description;
  final Color color;

  void showInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(descriptionTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(description),
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

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleRenameMe(days: days, message: label, color: color),
      IconButton(onPressed: () => showInfo(context), icon: Icon(Icons.info))
    ]);
  }
}

class CircleRenameMe extends StatelessWidget {
  const CircleRenameMe(
      {super.key, required this.days, required this.message, this.color});

  final int days;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color ?? Colors.grey),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$days Days",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message)
          ]),
    );
  }
}
