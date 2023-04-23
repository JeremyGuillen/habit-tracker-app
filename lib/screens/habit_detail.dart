import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/api/habit/habit-api.dart';

import '../models/habits.dart';

class HabitDetail extends StatefulWidget {
  const HabitDetail({super.key, required this.idHabit});

  final String idHabit;

  @override
  State<StatefulWidget> createState() {
    return _HabitDetail();
  }
}

class _HabitDetail extends State<HabitDetail> {
  bool loading = false;
  Habit? habitDetail = null;
  bool showError = false;
  @override
  void initState() {
    _getHabitDetail();
    super.initState();
  }

  void _getHabitDetail() async {
    print(widget.idHabit);
    setState(() {
      loading = true;
    });
    HabitApi api = HabitApi();
    Habit? habit = await api.getHabit(widget.idHabit);
    setState(() {
      loading = false;
      showError = habit == null;
      habitDetail = habit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Habit Detail"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: loading || habitDetail == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(habitDetail!.name),
                )
              ],
            ),
    ));
  }
}
