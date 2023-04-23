import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitCard extends StatelessWidget {
  const HabitCard(
      {super.key,
      required this.habitName,
      required this.habitDescription,
      required this.habitId});
  final String habitName;
  final String habitDescription;
  final String habitId;

  void onButtonTap(BuildContext context) {
    String uri = Uri(path: '/detail/$habitId').toString();
    print(uri);
    GoRouter.of(context).push(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(habitName), Text(habitDescription)],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                  onPressed: (() => onButtonTap(context)),
                  icon: Icon(Icons.arrow_right),
                  label: Text("Details")),
            ],
          )
        ],
      ),
    );
  }
}
