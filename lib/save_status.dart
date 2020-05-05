import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simple_mqtt_client/settings_store.dart';

class SaveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsStore>(
      builder: (context, settingStore, _) {
        if (settingStore.isSaved) {
          return Text("saved");
        } else {
          return Container();
        }
      },
    );
  }
}
