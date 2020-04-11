import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settings_store.dart';

class SmallInputField extends StatelessWidget {
  const SmallInputField(this.explanation, this.labelText, {Key key})
      : super(key: key);
  final String explanation;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsStore>(builder: (context, settingsStore, _) {
      return new Container(
        margin: const EdgeInsets.all(3.0),
        child: Row(
          children: <Widget>[
            Text(explanation),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: labelText),
                    onChanged: (text) => _setStore(settingsStore, text)),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _setStore(SettingsStore settingsStore, String text) {
    if (explanation == "Host") {
      settingsStore.setHost(text);
    } else if (explanation == "Port") {
      settingsStore.setPort(text);
    } else if (explanation == "Topic") {
      settingsStore.setTopic(text);
    } else if (explanation == "Name") {
      settingsStore.setName(text);
    } else {
      throw new StateError("explanation is unexpected value.");
    }
  }
}
