import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:national_train_hunter/model/service_message.dart';

class ServiceMessageRow extends StatelessWidget {
  final ServiceMessage _serviceMessage;

  ServiceMessageRow(this._serviceMessage);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ),
      leading: Icon(
        Icons.warning,
        color: Colors.yellow,
      ),
      title: Text(
        _parseHtmlString(_serviceMessage.message),
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
    );
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    return parse(document.body.text).documentElement.text;
  }
}
