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
  Habit? habitDetail;
  bool showError = false;
  @override
  void initState() {
    _getHabitDetail();
    super.initState();
  }

  void _getHabitDetail() async {
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

  void _onEditPress() async {
    print("Edit clicked");
  }

  void _onDeletePress() async {
    print("Delete click");
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(habitDetail!.name),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Ink(
                                    decoration: const ShapeDecoration(
                                        shape: CircleBorder(),
                                        color: Colors.lightBlue),
                                    child: IconButton(
                                      onPressed: _onEditPress,
                                      icon: Icon(Icons.edit),
                                      color: Colors.white,
                                    ))),
                            Container(
                                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Ink(
                                    decoration: const ShapeDecoration(
                                        shape: CircleBorder(),
                                        color: Colors.redAccent),
                                    child: IconButton(
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: ((context) => AlertDialog(
                                                title: const Text(
                                                    "Esta seguro que desea eliminar el habit"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _onDeletePress();
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              ))),
                                      icon: Icon(Icons.delete),
                                      color: Colors.white,
                                    ))),
                          ],
                        )
                      ]),
                )
              ],
            ),
    ));
  }
}
