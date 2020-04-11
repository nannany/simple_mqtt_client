import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PublishPage extends StatefulWidget {
  PublishPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  String dropdownValue = "one";
  String textContent = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.all(3.0),
                    child: Row(
                      children: <Widget>[
                        Text("Name"),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton(
                              value: dropdownValue,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                "one",
                                "two",
                                "threeeeeeeeeeeeeeeeeeeeeeeeeeeee"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(3.0),
                  child: Row(children: <Widget>[
                    Text("Message"),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 5,
                          maxLines: null,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          onChanged: (content) {
                            textContent = content;
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.content_copy, size: 25),
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: textContent));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 50),
//                  onPressed: () => Navigator.pop(context),
                  )),
              Container(
                margin: EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.publish, size: 50)),
              ),
            ],
          )
        ]));
  }
}
