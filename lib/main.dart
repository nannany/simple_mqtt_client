import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: '127.0.0.1'),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: '1883'),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'topic/aaa'),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'nannany'),
          )
        ],
      )),

    );
  }
}
