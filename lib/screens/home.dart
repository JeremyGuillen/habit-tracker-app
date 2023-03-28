import 'package:flutter/material.dart';
import 'package:habit_tracker/api/habit/habit-api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController habitName = TextEditingController();
  TextEditingController habitDescription = TextEditingController();

  Future<void> onPressCreateApi() async {
    if (habitName.text.isEmpty || habitDescription.text.isEmpty) {
      return;
    }
    var habitApi = HabitApi();
    Map<String, dynamic> habit = {
      'name': habitName.text,
      'description': habitDescription.text,
      'id_user': "0bf606b9-c5bf-4d86-a449-ded0bb904233"
    };
    await habitApi.createHabit(habit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit tracker app'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    controller: habitName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Habit Name'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    controller: habitDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Habit Description'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: (() => onPressCreateApi()),
                            child: Text('Crear Habito'))
                      ]),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
