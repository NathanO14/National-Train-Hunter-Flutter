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
    return BlocConsumer<LiveTrainsCubit, LiveTrainsState>(
      listener: (context, state) {
        if (state is LiveTrainsLoaded) {
          setState(() {
            _departures = state.departures;
            _messages = state.messages;
          });
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _form(),
                      _serviceMessagesCard(state),
                      _lineTrainsList(state),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _form() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TypeAheadFormField<Station>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _typeAheadControllerFrom,
                  decoration: InputDecoration(
                    labelText: _departing ? 'From' : 'At',
                    isDense: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _typeAheadControllerFrom.clear();
                      },
                    ),
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
                  _typeAheadControllerFrom.text = suggestion.stationName;
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
                    isDense: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _typeAheadControllerTo.clear();
                      },
                    ),
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
                  _typeAheadControllerTo.text = suggestion.stationName;
                  _selectedToStation = suggestion;
                },
                validator: (value) {
                  if (value.isEmpty) _selectedToStation = null;
                  return null;
                },
              ),
              Row(
                children: [
                  Flexible(
                    child: SwitchListTile(
                      dense: true,
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
                  FlatButton.icon(
                    icon: Icon(Icons.swap_calls_rounded),
                    label: Text('Swap'),
                    onPressed: () {
                      Station tempStation = _selectedFromStation;
                      _selectedFromStation = _selectedToStation;
                      _selectedToStation = tempStation;

                      setState(() {
                        _typeAheadControllerFrom.text =
                            _selectedFromStation?.stationName ?? '';
                        _typeAheadControllerTo.text =
                            _selectedToStation?.stationName ?? '';
                      });
                    },
                  ),
                ],
              ),
              RaisedButton(
                textColor: Colors.white,
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

  Widget _lineTrainsList(LiveTrainsState state) {
    return Expanded(
      child: SizedBox(
        height: 0.0,
        child: ListView.builder(
          itemCount: _departures.length,
          itemBuilder: (context, index) =>
              ServiceDepartureRow(_departures[index]),
        ),
      ),
    );
  }

  Widget _serviceMessagesCard(LiveTrainsState state) {
    if (state is LiveTrainsLoading) {
      return CircularProgressIndicator();
    } else if (_messages.isNotEmpty) {
      return _serviceMessages();
    } else {
      return Container(height: 0.0, width: 0.0);
    }
  }

  Widget _serviceMessages() {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text('Messages'),
      children: [
        for (ServiceMessage serviceMessage in _messages)
          ServiceMessageRow(serviceMessage),
      ],
    );
  }
}
