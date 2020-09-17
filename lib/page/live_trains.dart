import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
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
  bool _departing;
  List<Station> _stationResults = List();
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
        if (state is LiveTrainsStationsLoaded) {
          setState(() {
            _stationResults = state.stations;
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TypeAheadFormField<Station>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: this._typeAheadControllerFrom,
                  decoration: InputDecoration(
                    labelText: _departing ? 'From' : 'At',
                  ),
                ),
                suggestionsCallback: (String pattern) {
                  return BlocProvider.of<LiveTrainsCubit>(context)
                      .getStationBySearchTerm(pattern);
                  // return stationResults;
                },
                itemBuilder: (BuildContext context, Station suggestion) {
                  return ListTile(
                    title: Text(
                        '${suggestion.stationName} (${suggestion.stationCode})'),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (Station suggestion) {
                  this._typeAheadControllerFrom.text = suggestion.stationName;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please select a station';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _selectedFromStation = _stationResults.singleWhere(
                      (Station element) => element.stationName == value);
                },
              ),
              TypeAheadFormField<Station>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: this._typeAheadControllerTo,
                  decoration: InputDecoration(
                    labelText: _departing ? 'To' : 'From',
                  ),
                ),
                suggestionsCallback: (String pattern) {
                  return BlocProvider.of<LiveTrainsCubit>(context)
                      .getStationBySearchTerm(pattern);
                  // return stationResults;
                },
                itemBuilder: (BuildContext context, Station suggestion) {
                  return ListTile(
                    title: Text(
                        '${suggestion.stationName} (${suggestion.stationCode})'),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this._typeAheadControllerTo.text = suggestion.stationName;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please select a station';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _selectedToStation = _stationResults.singleWhere(
                      (Station element) => element.stationName == value);
                },
              ),
              SwitchListTile(
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
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Loading...'),
                      ),
                    );
                  }
                },
                child: Text('Go'),
              ),
            ],
          ),
        );
      },
    );
  }
}
