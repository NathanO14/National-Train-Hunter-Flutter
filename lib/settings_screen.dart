import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        sections: [
          SettingsSection(
            title: 'App Info',
            tiles: [
              SettingsTile(
                title: 'App Version',
                subtitle: '0.0.1',
                leading: Icon(Icons.system_update),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
