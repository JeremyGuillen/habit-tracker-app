import "package:flutter_secure_storage/flutter_secure_storage.dart";

class FlutterStore {
  static final FlutterStore _instance = FlutterStore._internal();
  final storage = FlutterSecureStorage();

  FlutterStore._internal();

  factory FlutterStore() {
    return _instance;
  }

  Future<String?> getValue(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  Future<void> storeValue(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> clearStore() async {
    await storage.deleteAll();
  }

  Future<void> deleteValue(String key) async {
    await storage.delete(key: key);
  }
}
