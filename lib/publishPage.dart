import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  PublishPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Text("new page"),
    );
  }
}
