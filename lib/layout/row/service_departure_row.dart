import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:national_train_hunter/model/service_departure.dart';

class ServiceDepartureRow extends StatelessWidget {
  final DateFormat _dateFormat = new DateFormat().add_Hm();
  final ServiceDeparture _serviceDeparture;

  ServiceDepartureRow(this._serviceDeparture);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: !_serviceDeparture.cancelled,
      // onTap: () {},
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
          border: new Border(
            right: new BorderSide(
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 22.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    _dateFormat.format(
                      _serviceDeparture.scheduledDepartureTime.toLocal(),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // isThreeLine: true,
      title: Text(
        _serviceDeparture.destinationStation,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: _serviceDeparture.cancelled
          ? Text(
              'Cancelled',
              style: TextStyle(
                color: Colors.red,
              ),
            )
          : _serviceDeparture.delayed
              ? Text(
                  'Delayed',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              : Text('On time'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Platform'),
          Text(
            _serviceDeparture.platform != null
                ? _serviceDeparture.platform
                : 'TBA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
