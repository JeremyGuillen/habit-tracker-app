import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_tracker/api/base_api_protected.dart';
import 'package:habit_tracker/models/habits.dart';

class HabitApi extends BaseApiProtected {
  static final HabitApi _instance =
      HabitApi._internal(dotenv.get('API_URL', fallback: ''));

  HabitApi._internal(super.baseUrl);

  factory HabitApi() {
    return _instance;
  }

  Future<void> createHabit(Map<String, dynamic> habit) async {
    var response = await post('habit', habit);
    if (response != null) {
      if (response.statusCode != 500) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        print(decodedResponse);
      }
    }
  }

  Future<List<Habit>> listHabits() async {
    var response = await get('habit');
    List<Habit> loadedHabits = [];
    if (response != null) {
      if (response.statusCode != 500) {
        final Map<String, dynamic> items = json.decode(response.body);
        List<Map<String, dynamic>> habits = List.from(items['items']);
        for (var habit in habits) {
          loadedHabits.add(Habit.fromJson(habit));
        }
        return loadedHabits;
      }
    }
    return loadedHabits;
  }
}
