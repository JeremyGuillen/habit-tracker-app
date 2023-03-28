import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_tracker/api/base_api_protected.dart';

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
}
