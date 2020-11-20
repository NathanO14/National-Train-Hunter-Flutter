import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_train_hunter/cubit/theme/theme_cubit.dart';
import 'package:national_train_hunter/enums/settings_type.dart';
import 'package:national_train_hunter/layout/message/pop_up_dialog.dart';
import 'package:national_train_hunter/util/string_util.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo _packageInfo;
  String _version;
  String _buildNumber;

  SharedPreferences _sharedPreferences;

  String _themeTypeKey = StringUtil.enumToString(SettingsType.DARK_THEME);
  bool _darkTheme = false;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initSharedPreferences();
  }

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
            title: 'Appearance',
            tiles: [
              SettingsTile(
                title: 'Theme',
                subtitle: _darkTheme ? 'Dark' : 'Light',
                leading: Icon(Icons.palette),
                onTap: () {
                  showDialog<dynamic>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return PopUpDialog(
                        dialogTitle: 'Set theme',
                        dialogBody: [
                          Column(
                            children: <Widget>[
                              RadioListTile<bool>(
                                key: Key('radio_light_theme'),
                                title: Text('Light'),
                                activeColor: Theme.of(context).accentColor,
                                value: false,
                                groupValue: _darkTheme,
                                onChanged: _changeTheme,
                              ),
                              RadioListTile<bool>(
                                key: Key('radio_dark_theme'),
                                title: Text('Dark'),
                                activeColor: Theme.of(context).accentColor,
                                value: true,
                                groupValue: _darkTheme,
                                onChanged: _changeTheme,
                              ),
                            ],
                          ),
                        ],
                        dialogActions: <Widget>[],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'App Info',
            tiles: [
              SettingsTile(
                title: 'Open Data',
                subtitle: 'Data provided by National Rail Enquiries',
                leading: Icon(Icons.api_rounded),
                onTap: () {},
              ),
              SettingsTile(
                title: 'App Version',
                subtitle: _version,
                leading: Icon(Icons.system_update_rounded),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Build Number',
                subtitle: _buildNumber,
                leading: Icon(Icons.build),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _darkTheme = _sharedPreferences.getBool(_themeTypeKey);
    });
  }

  void _initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    _version = _packageInfo.version;
    _buildNumber = _packageInfo.buildNumber;
  }

  void _changeTheme(bool darkTheme) {
    setState(() {
      _darkTheme = darkTheme;
      BlocProvider.of<ThemeCubit>(context).setTheme(_darkTheme);
    });

    Navigator.of(context).pop();
  }
}
