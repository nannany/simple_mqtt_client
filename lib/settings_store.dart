import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connection_setting.dart';

class SettingsStore with ChangeNotifier {
  String _host = "127.0.0.1";
  String _port = "1883";
  String _topic = "topic/rabbit";
  String _name = "nannany";
  bool _isConnecting = false;
  bool _isSaved = false;
  MqttConnectReturnCode _returnCode;

  void setHost(String host) {
    _host = host;
    notifyListeners();
  }

  void setPort(String port) {
    _port = port;
    notifyListeners();
  }

  void setTopic(String topic) {
    _topic = topic;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setIsSaved(bool isSaved) {
    _isSaved = isSaved;
    notifyListeners();
  }

  String get getHost => _host;

  String get getPort => _port;

  String get getTopic => _topic;

  String get getName => _name;

  bool get isConnecting => _isConnecting;

  bool get isSaved => _isSaved;

  MqttConnectReturnCode get getReturnCode => _returnCode;

  Future<void> connectMqttServer() async {
    _isConnecting = true;
    notifyListeners();

    int _targetPort = int.parse(_port);

    MqttServerClient _mqttClient =
        MqttServerClient.withPort(_host, _name, _targetPort);
    _mqttClient.logging(on: true);

    MqttClientConnectionStatus mqttClientConnectionStatus =
        MqttClientConnectionStatus();
    try {
      mqttClientConnectionStatus = await _mqttClient.connect();
    } catch (e) {
      _isConnecting = false;
      print(e);
    }

    _returnCode = mqttClientConnectionStatus.returnCode;
    print(_returnCode);

    _isConnecting = false;

    notifyListeners();
  }

  Future<bool> saveConnectionSetting(
      String key, ConnectionSetting value) async {
    _isSaved = false;

    final prefs = await SharedPreferences.getInstance();

    _isSaved = true;

    notifyListeners();

    return prefs.setString(key, json.encode(value));
  }
}
