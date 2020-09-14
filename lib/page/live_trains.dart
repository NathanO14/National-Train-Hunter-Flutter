import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LiveTrainsPage extends StatefulWidget {
  @override
  _LiveTrainsPageState createState() => _LiveTrainsPageState();
}

class _LiveTrainsPageState extends State<LiveTrainsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  bool departing;
  String _selectedStation;

  @override
  void initState() {
    super.initState();
    departing = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._typeAheadController,
              decoration: InputDecoration(
                labelText: 'From',
              ),
            ),
            suggestionsCallback: (pattern) {
              return null;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = suggestion;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please select a station';
              }
              return null;
            },
            onSaved: (value) => this._selectedStation = value,
          ),
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._typeAheadController,
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            suggestionsCallback: (pattern) {
              return null;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              this._typeAheadController.text = suggestion;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please select a station';
              }
              return null;
            },
            onSaved: (value) => this._selectedStation = value,
          ),
          SwitchListTile(
            title: Text(
              departing ? 'Departing' : 'Arriving',
            ),
            secondary: const Icon(Icons.import_export),
            value: departing,
            onChanged: (bool value) {
              setState(() {
                departing = value;
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
  }
}
