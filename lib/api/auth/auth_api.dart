import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habit_tracker/api/base_api.dart';
import 'package:habit_tracker/models/sign_in_response.dart';

class AuthApi extends BaseApi {
  static final AuthApi _instance =
      AuthApi._internal(dotenv.get('API_URL', fallback: ''));

  AuthApi._internal(super.baseUrl);

  factory AuthApi() {
    return _instance;
  }

  Future<SignInResponse?> signIn(Map<String, dynamic> credentials) async {
    var response = await post('auth/sign-in', credentials);
    if (response != null) {
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        SignInResponse signInResponse =
            SignInResponse.fromJson(decodedResponse);
        print(signInResponse.expiresIn);
        return signInResponse;
      }
      return null;
    } else {
      return null;
    }
  }
}
