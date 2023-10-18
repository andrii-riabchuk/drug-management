import 'package:flutter/material.dart';

class SecretPage extends StatelessWidget {
  const SecretPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("-----------")),
      body: Center(child: Text("TOP SECRET")),
    );
  }
}
