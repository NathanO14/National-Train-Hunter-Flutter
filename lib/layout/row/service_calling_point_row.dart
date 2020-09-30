import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:national_train_hunter/model/enums/forecast_type.dart';
import 'package:national_train_hunter/model/service_calling_point.dart';

class ServiceCallingPointRow extends StatelessWidget {
  final DateFormat _dateFormat = new DateFormat().add_Hm();
  final ServiceCallingPoint _serviceCallingPoint;

  ServiceCallingPointRow(this._serviceCallingPoint);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enabled: _serviceCallingPoint.departureType == ForecastType.FORECAST ||
          _serviceCallingPoint.arrivalType == ForecastType.FORECAST,
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
                      _serviceCallingPoint.scheduledDepartureTime != null
                          ? _serviceCallingPoint.scheduledDepartureTime
                              .toLocal()
                          : _serviceCallingPoint.scheduledArrivalTime.toLocal(),
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
        _serviceCallingPoint.stationName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: _time(),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Platform'),
          Text(
            _serviceCallingPoint.platform != null
                ? _serviceCallingPoint.platform
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

  Widget _time() {
    if (_serviceCallingPoint.departureType == ForecastType.ACTUAL) {
      return Text(
        'Departed: '
        '${_dateFormat.format(_serviceCallingPoint.actualDepartureTime.toLocal())}',
      );
    } else if (_serviceCallingPoint.departureType == ForecastType.FORECAST) {
      return Text(
        'Expected departure: '
        '${_dateFormat.format(_serviceCallingPoint.estimatedDepartureTime.toLocal())}',
      );
    } else if (_serviceCallingPoint.arrivalType == ForecastType.FORECAST) {
      return Text(
        'Expected arrival: '
        '${_dateFormat.format(_serviceCallingPoint.estimatedArrivalTime.toLocal())}',
      );
    } else if (_serviceCallingPoint.arrivalType == ForecastType.ACTUAL) {
      return Text(
        'Arrived: '
        '${_dateFormat.format(_serviceCallingPoint.actualArrivalTime.toLocal())}',
      );
    } else if (_serviceCallingPoint.cancelled) {
      return Text(
        'Cancelled',
        style: TextStyle(
          color: Colors.red,
        ),
      );
    }

    return Container();
  }
}
