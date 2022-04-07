import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService _instance;
  static SharedPreferences _preferences;

  static Future<String> get(String key) async {
    var ret;
    _preferences = await SharedPreferences.getInstance();
    ret = _preferences.get(key);
    return ret;
  }

  static void save(String key, String value) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString(key, value);
    _preferences.reload();
  }

  static void clear({String key}) async {
    _preferences = await SharedPreferences.getInstance();

    if (key == null) {
      _preferences.clear();
    } else {
      _preferences.remove(key);
    }
    _preferences.reload();
  }
}
