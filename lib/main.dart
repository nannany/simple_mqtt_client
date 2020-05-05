import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/save_status.dart';
import 'package:simple_mqtt_client/settings_store.dart';

import 'package:simple_mqtt_client/small_input_field.dart';

import 'connect_status.dart';
import 'connection_setting.dart';
import 'publish_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple MQTT Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<SettingsStore>(
          create: (context) => SettingsStore(),
          child: MainPage(title: 'Simple MQTT Client')),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            ChangeNotifierProvider<SettingsStore>(
                create: (context) => SettingsStore(),
                child: new MainPage(title: 'Simple MQTT Client')),
        '/publish': (BuildContext context) =>
            ChangeNotifierProvider<SettingsStore>(
                create: (context) => SettingsStore(),
                child: new PublishPage(title: 'Simple MQTT Client'))
      },
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final settingsState = Provider.of<SettingsStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SmallInputField("Host", "ex)127.0.0.1"),
                SmallInputField("Port", "ex)1883"),
                SmallInputField("Name", "ex)nannany"),
              ],
            ),
          ),
          ConnectStatus(),
          SaveStatus(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(Icons.link, size: 50),
                      onPressed: () => settingsState.connectMqttServer())),
              Container(
                margin: EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.save, size: 50),
                  onPressed: settingsState.isSaveButtonEnable
                      ? () => settingsState.saveConnectionSetting(
                          settingsState.getName,
                          ConnectionSetting(settingsState.getHost,
                              settingsState.getPort, settingsState.getName))
                      : null,
                  disabledColor: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.arrow_right, size: 50),
                    onPressed: () =>
                        Navigator.of(context).pushNamed("/publish")),
              )
            ],
          ),
        ],
      ),
    );
  }
}
