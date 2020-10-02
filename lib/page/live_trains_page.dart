import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:national_train_hunter/cubit/live_trains_cubit.dart';
import 'package:national_train_hunter/layout/row/service_departure_row.dart';
import 'package:national_train_hunter/layout/row/service_message_row.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:national_train_hunter/model/service_message.dart';
import 'package:national_train_hunter/model/station.dart';

class LiveTrainsPage extends StatefulWidget {
  @override
  _LiveTrainsPageState createState() => _LiveTrainsPageState();
}

class _LiveTrainsPageState extends State<LiveTrainsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadControllerFrom =
      TextEditingController();
  final TextEditingController _typeAheadControllerTo = TextEditingController();
  bool _departing;
  List<ServiceDeparture> _departures = List();
  List<ServiceMessage> _messages = List();
  Station _selectedFromStation;
  Station _selectedToStation;

  @override
  void initState() {
    super.initState();
    _departing = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<LiveTrainsCubit, LiveTrainsState>(
        listener: (context, state) {
          if (state is LiveTrainsLoaded) {
            setState(() {
              _departures = state.departures;
              _messages = state.messages;
            });
          }
        },
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _form(),
                      _serviceMessagesCard(state),
                      _liveTrainsCard(state),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _form() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
                },
                autovalidate: true,
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
                  _selectedFromStation = suggestion;
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    _selectedFromStation = null;
                  }
                  return null;
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
                  _selectedToStation = suggestion;
                },
                validator: (value) {
                  if (value.isEmpty) _selectedToStation = null;
                  return null;
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
                    BlocProvider.of<LiveTrainsCubit>(context).getDepartures(
                        _selectedFromStation?.stationCode,
                        _selectedToStation?.stationCode,
                        _departing);
                  }
                },
                child: Text('Go'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liveTrainsCard(LiveTrainsState state) {
    if (state is LiveTrainsLoaded) {
      return Card(
        child: _list(state),
      );
    } else {
      return Spacer();
    }
  }

  Widget _list(LiveTrainsState state) {
    return Column(
      children: [
        for (ServiceDeparture departure in _departures)
          ServiceDepartureRow(departure),
      ],
    );
  }

  Widget _serviceMessagesCard(LiveTrainsState state) {
    if (state is LiveTrainsLoading) {
      return CircularProgressIndicator();
    } else if (state is LiveTrainsLoaded && _messages.isNotEmpty) {
      return _serviceMessages(state);
    } else {
      return Spacer();
    }
  }

  Widget _serviceMessages(LiveTrainsLoaded state) {
    return Expanded(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text('Messages'),
        children: [
          for (ServiceMessage serviceMessage in _messages)
            ServiceMessageRow(serviceMessage),
        ],
      ),
    );
  }
}
