import 'dart:convert';

import 'package:flutter/material.dart';
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
  String _message = "";
  String _targetHost;
  String _targetPort;
  bool _isConnecting = false;
  bool _isSaved = false;
  bool _isSaveButtonEnable = false;
  MqttConnectReturnCode _returnCode;
  TextStyle _saveStatusTextStatus = _initialSaveStatusTextStyle;

  static TextStyle _initialSaveStatusTextStyle =
      TextStyle(color: Colors.black, fontSize: 0);

  static TextStyle _transformedSaveStatusTextStyle =
      TextStyle(color: Colors.blueAccent, fontSize: 20);

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

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  void setTargetHost(String targetHost) {
    _targetHost = targetHost;
    notifyListeners();
  }

  void setTargetPort(String targetPort) {
    _targetPort = targetPort;
    notifyListeners();
  }

  void setIsSaved(bool isSaved) {
    _isSaved = isSaved;
    notifyListeners();
  }

  void setIsSaveButtonEnable(bool isSaveButtonEnable) {
    _isSaveButtonEnable = isSaveButtonEnable;
    notifyListeners();
  }

  void setSaveStatusTextStyleDefault() {
    _saveStatusTextStatus = _initialSaveStatusTextStyle;
    _isSaveButtonEnable = false;
    notifyListeners();
  }

  String get getHost => _host;

  String get getPort => _port;

  String get getTopic => _topic;

  String get getName => _name;

  String get getMessage => _message;

  String get getTargetHost => _targetHost;

  String get getTargetPort => _targetPort;

  bool get isConnecting => _isConnecting;

  bool get isSaved => _isSaved;

  bool get isSaveButtonEnable => _isSaveButtonEnable;

  MqttConnectReturnCode get getReturnCode => _returnCode;

  TextStyle get getSaveStatusTextStyle => _saveStatusTextStatus;

  Future<void> connectMqttServer() async {
    _isConnecting = true;
    notifyListeners();

    int _intPort = int.parse(_port);

    MqttServerClient _mqttClient =
        MqttServerClient.withPort(_host, _name, _intPort);
    _mqttClient.logging(on: true);

    MqttClientConnectionStatus mqttClientConnectionStatus =
        MqttClientConnectionStatus();
    try {
      mqttClientConnectionStatus = await _mqttClient.connect();
      _isSaveButtonEnable = true;
    } catch (e) {
      _isConnecting = false;
      print(e);
    }

    _returnCode = mqttClientConnectionStatus.returnCode;
    print(_returnCode);

    _isConnecting = false;

    notifyListeners();
  }

  Future<void> publishMessageToMqttServer() async {

  }

  Future<bool> saveConnectionSetting(
      String key, ConnectionSetting value) async {
    _isSaved = false;

    final prefs = await SharedPreferences.getInstance();

    _isSaved = true;
    _saveStatusTextStatus = _transformedSaveStatusTextStyle;

    notifyListeners();

    return prefs.setString(key, json.encode(value));
  }
}
