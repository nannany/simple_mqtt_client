import 'package:flutter/widgets.dart';

class SettingsStore with ChangeNotifier {
  var host = "127.0.0.1";
  var port = "1883";
  var topic = "topic/rabbit";
  var name = "nannany";

  void setHost(String host) {
    this.host = host;
    notifyListeners();
  }

  void setPort(String port) {
    this.port = port;
    notifyListeners();
  }

  void setTopic(String topic) {
    this.topic = topic;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }


}
