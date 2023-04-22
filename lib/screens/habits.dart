import 'package:flutter/material.dart';

class Habits extends StatefulWidget {
  const Habits({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Habits();
  }
}

class _Habits extends State<Habits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habits List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Habits Screen")],
      ),
    );
  }
}
