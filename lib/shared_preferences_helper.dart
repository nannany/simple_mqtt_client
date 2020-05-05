import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  static Future<String> getConnectionSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? '';
  }

  static Future<List<String>> getAllConnectionSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getKeys().map<String>((key) => prefs.get(key)).toList();
  }

  static Future<void> deleteAllConnectionSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getKeys().forEach((key) => prefs.remove(key));
  }
}
