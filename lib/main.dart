import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settingsStore.dart';

//import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:simple_mqtt_client/smallInputField.dart';

import 'publishPage.dart';

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
      home: MainPage(title: 'Simple MQTT Client'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) =>
            new MainPage(title: 'Simple MQTT Client'),
        '/publish': (BuildContext context) =>
            new PublishPage(title: 'Simple MQTT Client')
      },
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ChangeNotifierProvider(
        create: (context) => SettingsStore(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SmallInputField("Host", "127.0.0.1"),
                  SmallInputField("Port", "1883"),
                  SmallInputField("Topic", "topic/rabbit"),
                  SmallInputField("Name", "nannany"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.link, size: 50),
                      onPressed: () => {
//                       mqttClient = _mqttClientBuilder(context);
                      },
                    )),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.save, size: 50),
                    onPressed: () => {},
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
      ),
    );
  }

//  MqttClient _mqttClientBuilder(BuildContext context) {
//    final server = Provider.of<SettingsStore>(context).host;
//    final clientIdentifier = Provider.of<SettingsStore>(context).name;
//    var port;
//    try {
//      port = int.parse(Provider.of<SettingsStore>(context).port);
//    } catch (exception) {
//      port = 1883;
//    }
//    return MqttBrowserClient.withPort(server, clientIdentifier, port);
//  }
}
