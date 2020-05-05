import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settings_store.dart';

class SaveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsStore>(
      builder: (context, settingStore, _) {
        return AnimatedDefaultTextStyle(
          duration: const Duration(seconds: 2),
          style: settingStore.getSaveStatusTextStyle,
          child: Text("saved"),
          curve: Curves.ease,
          onEnd: () => settingStore.setSaveStatusTextStyleDefault(),
        );
      },
    );
  }
}
