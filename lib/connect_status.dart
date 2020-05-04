import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settings_store.dart';

class ConnectStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsStore>(builder: (context, settingStore, _) {
      if (settingStore.isConnecting) {
        return CircularProgressIndicator();
      } else if (settingStore.getReturnCode ==
          MqttConnectReturnCode.connectionAccepted) {
        return Text('Connected!');
      } else if (settingStore.getReturnCode == null) {
        return null;
      } else {
        return Text('Connection Failed');
      }
    });
  }
}
