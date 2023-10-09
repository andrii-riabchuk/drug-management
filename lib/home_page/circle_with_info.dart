import 'package:flutter/material.dart';

class CircleWithInfo extends StatelessWidget {
  const CircleWithInfo(
      {super.key,
      required this.days,
      required this.message,
      required this.color});

  final int days;
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleRenameMe(days: days, message: message, color: color),
      IconButton(onPressed: () {}, icon: Icon(Icons.info))
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
