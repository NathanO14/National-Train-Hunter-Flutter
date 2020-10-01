import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
import 'package:national_train_hunter/cubit/service_information_cubit.dart';
import 'package:national_train_hunter/home_screen.dart';
import 'package:national_train_hunter/service/service_departure_service.dart';
import 'package:national_train_hunter/service/station_service.dart';
import 'package:national_train_hunter/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: MaterialApp(
          title: kAppName,
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            cardTheme: CardTheme(
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            accentColor: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            cardTheme: CardTheme(
              margin: EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            // '/service-information': (context) => ServiceInformationScreen(),
            '/settings': (context) => SettingsScreen(),
          }),
    );
  }
}
