import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_tracker/api/base_api.dart';

class AuthApi extends BaseApi {
  static final AuthApi _instance =
      AuthApi._internal(dotenv.get('API_URL', fallback: ''));

  AuthApi._internal(super.baseUrl);

  factory AuthApi() {
    return _instance;
  }

  Future<Map?> signIn(Map<String, dynamic> credentials) async {
    var response = await post('auth/signIn', credentials);
    if (response != null) {
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return decodedResponse;
    } else {
      return null;
    }
  }
}
