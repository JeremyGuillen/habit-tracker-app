import 'package:flutter/material.dart';

class HabitDetail extends StatelessWidget {
  const HabitDetail({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Habit Detail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Habit detail page"),
          )
        ],
      ),
    ));
  }
}
