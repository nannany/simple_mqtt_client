import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
        '/home': (BuildContext context) => new MainPage(title: 'Simple MQTT Client'),
        '/publish': (BuildContext context) => new PublishPage(title: 'Simple MQTT Client')
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
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
//                  onPressed: () => Navigator.pop(context),
                  )),
              Container(
                margin: EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.save, size: 50)),
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

  Widget _buildInputField(String explanation, String labelText) {
    return new Container(
      margin: const EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          Text(explanation),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: labelText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
