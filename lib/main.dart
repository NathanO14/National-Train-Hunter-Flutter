import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/constants/widget_constants.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
import 'package:national_train_hunter/cubit/service_information_cubit.dart';
import 'package:national_train_hunter/cubit/theme/theme_cubit.dart';
import 'package:national_train_hunter/home_screen.dart';
import 'package:national_train_hunter/initializer/app_initializer.dart';
import 'package:national_train_hunter/service/service_departure_service.dart';
import 'package:national_train_hunter/service/station_service.dart';
import 'package:national_train_hunter/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppInitializer.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<LiveTrainsCubit>(
          create: (context) => LiveTrainsCubit(
            StationService(),
            ServiceDepartureService(),
          ),
        ),
        BlocProvider<ServiceInformationCubit>(
          create: (context) => ServiceInformationCubit(
            ServiceDepartureService(),
          ),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              title: kAppName,
              theme: _getTheme(context, state),
              initialRoute: '/',
              routes: {
                '/': (context) => HomeScreen(),
                // '/service-information': (context) => ServiceInformationScreen(),
                '/settings': (context) => SettingsScreen(),
              });
        },
      ),
    );
  }

  ThemeData _getTheme(BuildContext context, ThemeState state) {
    if (state is ThemeDark) {
      return _darkTheme(context);
    } else {
      return _lightTheme(context);
    }
  }

  ThemeData _lightTheme(BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      canvasColor: kCanvasColor,
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
      primaryColor: kAccentColour,
      accentColor: kAccentColour,
      scaffoldBackgroundColor: kCanvasColor,
      textTheme: GoogleFonts.manropeTextTheme(
        Theme.of(context).textTheme,
      ).copyWith(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        headline3: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        caption: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
        overline: TextStyle(color: Colors.black),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.white,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }

  ThemeData _darkTheme(BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
      accentColor: kAccentColour,
      canvasColor: kDarkCanvasColor,
      textTheme: GoogleFonts.manropeTextTheme(
        Theme.of(context).textTheme,
      ).copyWith(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        headline3: TextStyle(color: Colors.white),
        headline4: TextStyle(color: Colors.white),
        headline5: TextStyle(color: Colors.white),
        headline6: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.white),
        button: TextStyle(color: Colors.white),
        overline: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: kDarkCanvasColor,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline6: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
          overline: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
