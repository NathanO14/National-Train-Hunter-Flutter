import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:national_train_hunter/enums/settings_type.dart';
import 'package:national_train_hunter/util/string_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  SharedPreferences _sharedPreferences;

  ThemeCubit() : super(ThemeInitial()) {
    _getTheme();
  }

  Future<void> _getTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool darkTheme = _sharedPreferences
        .getBool(StringUtil.enumToString(SettingsType.DARK_THEME));

    if (darkTheme) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  Future<void> setTheme(bool darkTheme) async {
    String themeTypeKey = StringUtil.enumToString(SettingsType.DARK_THEME);
    _sharedPreferences.setBool(themeTypeKey, darkTheme);

    if (darkTheme) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }
}
