import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    _loadItems(null);
    super.initState();
  }

  Future<void> _loadItems(dynamic value) async {
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

  void _onAddPressed(BuildContext context) {
    String uri = Uri(path: '/create-habit').toString();
    GoRouter.of(context).push(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Habits List"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddPressed(context),
          shape: CircleBorder(),
          child: Icon(Icons.add),
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
