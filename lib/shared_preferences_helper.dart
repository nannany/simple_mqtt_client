import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_mqtt_client/connection_setting.dart';

class SharedPreferencesHelper{

  static Future<bool> saveConnectionSetting(String key, ConnectionSetting value) async{
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, json.encode(value));
  }

  static Future<String> getConnectionSetting(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? '';
  }

}