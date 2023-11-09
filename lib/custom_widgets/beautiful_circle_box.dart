import 'package:flutter/material.dart';

class BeautifulCircleBox extends StatelessWidget {
  const BeautifulCircleBox({super.key, this.color, this.child});

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color ?? Colors.grey),
      child: child,
    );
  }
}

class Counter extends StatelessWidget {
  const Counter(this.days, this.message, {super.key});

  final int days;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (days != 999999) ? "$days Days" : "Always",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(message)
        ]);
  }
}
