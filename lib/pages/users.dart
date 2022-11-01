import 'package:flutter/material.dart';

class Integrantes extends StatelessWidget {
  const Integrantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child:
            Text("Javier Leiva y Daniel Lopez", style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
