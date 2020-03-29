import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
      home: MyHomePage(title: 'Simple MQTT Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  _buildInputField("Host", "127.0.0.1"),
                  _buildInputField("Port", "1883"),
                  _buildInputField("Topic", "topic/rabbit"),
                  _buildInputField("Name", "nannany"),
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
                  child: IconButton(icon: Icon(Icons.arrow_right, size: 50)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String explanation, String labelText) {
    return new Container(
      margin: const EdgeInsets.all(8.0),
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
