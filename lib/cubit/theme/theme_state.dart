part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();

  @override
  List<Object> get props => [];
}

class ThemeDark extends ThemeState {
  const ThemeDark();

  @override
  List<Object> get props => [];
}

class ThemeLight extends ThemeState {
  const ThemeLight();

  @override
  List<Object> get props => [];
}
