import 'package:flutter/material.dart';
import 'package:habit_tracker/api/habit/habit-api.dart';
import 'package:habit_tracker/models/habits.dart';
import 'package:habit_tracker/widgets/habit_card.dart';

class Habits extends StatefulWidget {
  const Habits({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Habits();
  }
}

class _Habits extends State<Habits> {
  List<Habit> habitsList = [];
  bool loading = false;
  int itemsCount = 0;
  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    var habitsApi = HabitApi();
    setState(() {
      loading = true;
    });
    List<Habit> loadedHabits = await habitsApi.listHabits();
    for (Habit habit in loadedHabits) {
      print(habit.name);
    }
    setState(() {
      loading = false;
      habitsList = loadedHabits;
      itemsCount = loadedHabits.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Habits List"),
        ),
        body: itemsCount > 0
            ? ListView.separated(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                itemCount: itemsCount,
                itemBuilder: (BuildContext context, int index) {
                  return HabitCard(
                      habitName: habitsList[index].name,
                      habitDescription: habitsList[index].description,
                      habitId: habitsList[index].idHabit);
                },
                separatorBuilder: (context, index) => const Divider(),
              )
            : const Center(
                child: Text('No Items'),
              ));
  }
}
