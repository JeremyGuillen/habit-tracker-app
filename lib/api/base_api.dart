import 'package:http/http.dart';
import 'dart:convert';

class BaseApi {
  Client client = Client();
  String _baseUrl;

  BaseApi(this._baseUrl);

  Future<Response?> get(String path) async {
    try {
      var uri = Uri.https(_baseUrl, path);
      var response = await client.get(uri);
      return response;
    } catch (e) {
      print(e);
      return null;
    } finally {
      client.close();
    }
  }

  Future<Response?> post(String path, Map<String, dynamic> body) async {
    try {
      var url = _createUri(path);
      var response = await client.post(url, body: json.encode(body));
      return response;
    } catch (e) {
      print(e);
      return null;
    } finally {
      client.close();
    }
  }

  Future<Response?> put(String path, Map<String, dynamic> body) async {
    try {
      var url = _createUri(path);
      var response = await client.post(url, body: json.encode(body));
      return response;
    } catch (e) {
      print(e);
      return null;
    } finally {
      client.close();
    }
  }

  Future<Response?> delete(String path, Map<String, dynamic> body) async {
    try {
      var url = _createUri(path);
      var response = await client.post(url);
      return response;
    } catch (e) {
      print(e);
      return null;
    } finally {
      client.close();
    }
  }

  Uri _createUri(String path) {
    return Uri.https(_baseUrl, path);
  }
}
