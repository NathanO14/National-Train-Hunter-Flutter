import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
import 'package:national_train_hunter/home_screen.dart';
import 'package:national_train_hunter/service/service_departure_service.dart';
import 'package:national_train_hunter/service/station_service.dart';

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
      ],
      child: MaterialApp(
        title: kAppName,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          accentColor: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
