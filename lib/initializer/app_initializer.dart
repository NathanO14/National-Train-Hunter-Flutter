import 'package:national_train_hunter/enums/settings_type.dart';
import 'package:national_train_hunter/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer {
  static void initialize() async {
    await _initSharedPreferences();
  }

  static Future<void> _initSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String themeTypeKey = StringUtil.enumToString(SettingsType.DARK_THEME);
    bool themeTypeValue = false;
    if (!sharedPreferences.containsKey(themeTypeKey)) {
      sharedPreferences.setBool(themeTypeKey, themeTypeValue);
    }
  }
}
