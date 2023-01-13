import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  static Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  static Future clear({
    List<String> whiteList = const [],
  }) async {
    for (final key in _prefs.getKeys()) {
      if (!whiteList.contains(key)) {
        await _prefs.remove(key);
      }
    }
  }

  static Future clearOnlyKeysWithPrefix(
    String prefix,
  ) async {
    for (final key in _prefs.getKeys()) {
      if (key.startsWith(prefix)) {
        await _prefs.remove(key);
      }
    }
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  static Set<String> getKeys() {
    return _prefs.getKeys();
  }

  static Object? get(String key) {
    return _prefs.get(key);
  }
}
