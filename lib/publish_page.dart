import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settings_store.dart';
import 'package:simple_mqtt_client/shared_preferences_helper.dart';
import 'package:simple_mqtt_client/small_input_field.dart';

import 'connection_setting.dart';

class PublishPage extends StatefulWidget {
  PublishPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  String dropdownValue;
  Future<List<String>> connectSettingList;

  @override
  void initState() {
    super.initState();
    connectSettingList = SharedPreferencesHelper.getAllConnectionSettings();
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = Provider.of<SettingsStore>(context);
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
                          child: FutureBuilder(
                              future: connectSettingList,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.isEmpty) {
                                    return Text(
                                      "No connection setting detected",
                                    );
                                  } else {
                                    List<ConnectionSetting>
                                        _connectionSettingList = snapshot.data
                                            .map<ConnectionSetting>(
                                                (String jsonStr) {
                                      return ConnectionSetting.fromJson(
                                          jsonDecode(jsonStr));
                                    }).toList();
                                    return Column(
                                      children: <Widget>[
                                        DropdownButton(
                                            value: dropdownValue ??
                                                _connectionSettingList[0].name,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                dropdownValue = newValue;
                                              });
                                            },
                                            items: _connectionSettingList
                                                .map<DropdownMenuItem<String>>(
                                                    (ConnectionSetting cs) {
                                              return DropdownMenuItem<String>(
                                                value: cs.name,
                                                child: Text(cs.name),
                                              );
                                            }).toList()),
                                        Text(settingsState.getHostAndPort(
                                            _connectionSettingList,
                                            dropdownValue))
                                      ],
                                    );
                                  }
                                } else {
                                  return Text(
                                    "Loading",
                                  );
                                }
                              }),
                        ),
                      ],
                    )),
                SmallInputField("Topic", "ex)topic/rabbit"),
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
                            settingsState.setMessage(content);
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
                                ClipboardData(text: settingsState.getMessage));
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
                    icon: Icon(Icons.delete_forever, size: 50),
                    onPressed: () =>
                        SharedPreferencesHelper.deleteAllConnectionSettings(),
                  )),
              Container(
                  margin: EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 50),
                  onPressed: () => Navigator.pop(context),
                  )),
              Container(
                margin: EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.publish, size: 50),
                    onPressed: () =>
                        settingsState.publishMessageToMqttServer()),
              ),
            ],
          )
        ]));
  }
}
