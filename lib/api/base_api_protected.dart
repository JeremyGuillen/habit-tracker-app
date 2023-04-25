import 'package:habit_tracker/api/guard_interceptor.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:http_interceptor/http/http.dart';

class BaseApiProtected {
  Client client = InterceptedClient.build(interceptors: [
    GuardInterceptor(),
  ]);
  String _baseUrl;

  BaseApiProtected(this._baseUrl);

  Future<Response?> get(String path) async {
    try {
      var uri = Uri.https(_baseUrl, path);
      var response = await client.get(uri);
      print(response);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> post(String path, Map<String, dynamic> body) async {
    try {
      var url = _createUri(path);
      print(url);
      var response = await client.post(url, body: json.encode(body));
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> put(String path, Map<String, dynamic> body) async {
    try {
      var url = _createUri(path);
      var response = await client.put(url, body: json.encode(body));
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> delete(String path) async {
    try {
      var url = _createUri(path);
      var response = await client.delete(url);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Uri _createUri(String path) {
    return Uri.https(_baseUrl, path);
  }

  Map<String, dynamic> parseResponse(Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  }
}
