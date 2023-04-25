import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/api/habit/habit-api.dart';

class CreateHabit extends StatefulWidget {
  const CreateHabit({super.key});

  @override
  State<CreateHabit> createState() => _CreateHabit();
}

class _CreateHabit extends State<CreateHabit> {
  TextEditingController habitName = TextEditingController();
  TextEditingController habitDescription = TextEditingController();
  bool _loading = false;

  Future<void> onPressCreateHabit() async {
    if (habitName.text.isEmpty || habitDescription.text.isEmpty) {
      return;
    }
    setState(() {
      _loading = true;
    });
    var habitApi = HabitApi();
    Map<String, dynamic> habit = {
      'name': habitName.text,
      'description': habitDescription.text,
      'id_user': "0bf606b9-c5bf-4d86-a449-ded0bb904233"
    };
    await habitApi.createHabit(habit);
    setState(() {
      _loading = false;
    });

    // ignore: use_build_context_synchronously
    context.push('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.push('/home'),
        ),
        title: Text('Create Habit'),
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
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  alignment: Alignment.center,
                  child: Text('Create Habit',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                ),
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
                        ElevatedButton.icon(
                            onPressed: (() => onPressCreateHabit()),
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16.0)),
                            icon: _loading
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.blue,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Icon(Icons.send),
                            label: const Text("Create Habit")),
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
