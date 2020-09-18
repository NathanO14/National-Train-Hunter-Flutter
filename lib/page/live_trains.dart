import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:national_train_hunter/model/station.dart';
import 'package:simple_logger/simple_logger.dart';

class LiveTrainsPage extends StatefulWidget {
  @override
  _LiveTrainsPageState createState() => _LiveTrainsPageState();
}

class _LiveTrainsPageState extends State<LiveTrainsPage> {
  final SimpleLogger _logger = SimpleLogger();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadControllerFrom =
      TextEditingController();
  final TextEditingController _typeAheadControllerTo = TextEditingController();
  final DateFormat _dateFormat = new DateFormat().add_Hm();
  bool _departing;
  List<ServiceDeparture> _departures = List();
  Station _selectedFromStation;
  Station _selectedToStation;

  @override
  void initState() {
    super.initState();
    _departing = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveTrainsCubit, LiveTrainsState>(
      listener: (context, state) {
        if (state is LiveTrainsLoaded) {
          setState(() {
            _departures = state.departures;
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: TypeAheadFormField<Station>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this._typeAheadControllerFrom,
                          decoration: InputDecoration(
                            labelText: _departing ? 'From' : 'At',
                          ),
                        ),
                        suggestionsCallback: (String pattern) {
                          return BlocProvider.of<LiveTrainsCubit>(context)
                              .getStationBySearchTerm(pattern);
                        },
                        autovalidate: true,
                        itemBuilder:
                            (BuildContext context, Station suggestion) {
                          return ListTile(
                            title: Text(
                                '${suggestion.stationName} (${suggestion.stationCode})'),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (Station suggestion) {
                          this._typeAheadControllerFrom.text =
                              suggestion.stationName;
                          _selectedFromStation = suggestion;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            _selectedFromStation = null;
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: TypeAheadFormField<Station>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: this._typeAheadControllerTo,
                          decoration: InputDecoration(
                            labelText: _departing ? 'To' : 'From',
                          ),
                        ),
                        suggestionsCallback: (String pattern) {
                          return BlocProvider.of<LiveTrainsCubit>(context)
                              .getStationBySearchTerm(pattern);
                        },
                        itemBuilder:
                            (BuildContext context, Station suggestion) {
                          return ListTile(
                            title: Text(
                                '${suggestion.stationName} (${suggestion.stationCode})'),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadControllerTo.text =
                              suggestion.stationName;
                          _selectedToStation = suggestion;
                        },
                        validator: (value) {
                          if (value.isEmpty) _selectedToStation = null;
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: SwitchListTile(
                        title: Text(
                          _departing ? 'Departing' : 'Arriving',
                        ),
                        secondary: const Icon(Icons.import_export),
                        value: _departing,
                        onChanged: (bool value) {
                          setState(() {
                            _departing = value;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            BlocProvider.of<LiveTrainsCubit>(context)
                                .getDepartures(
                                    _selectedFromStation?.stationCode,
                                    _selectedToStation?.stationCode,
                                    _departing);
                          }
                        },
                        child: Text('Go'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is LiveTrainsLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (state is LiveTrainsLoaded)
              Flexible(
                flex: 2,
                child: ListView.builder(
                  itemCount: _departures.length,
                  itemBuilder: (BuildContext context, int index) {
                    ServiceDeparture departure = _departures[index];
                    return ListTile(
                      leading: Text(
                        _dateFormat.format(
                          departure.scheduledDepartureTime.toLocal(),
                        ),
                      ),
                      title: Text(
                        departure.destinationStation,
                      ),
                      trailing: Text(departure.platform),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
