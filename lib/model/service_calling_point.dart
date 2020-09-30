import 'package:json_annotation/json_annotation.dart';
import 'package:national_train_hunter/model/enums/forecast_type.dart';

part 'service_calling_point.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceCallingPoint {
  String crs;
  String stationName;
  String platform;
  DateTime scheduledArrivalTime;
  DateTime actualArrivalTime;
  DateTime estimatedArrivalTime;
  ForecastType arrivalType;
  DateTime scheduledDepartureTime;
  DateTime actualDepartureTime;
  DateTime estimatedDepartureTime;
  ForecastType departureType;
  bool cancelled;

  ServiceCallingPoint({
    this.crs,
    this.stationName,
    this.platform,
    this.scheduledArrivalTime,
    this.actualArrivalTime,
    this.estimatedArrivalTime,
    this.scheduledDepartureTime,
    this.actualDepartureTime,
    this.estimatedDepartureTime,
    this.cancelled,
  });

  factory ServiceCallingPoint.fromJson(Map<String, dynamic> json) =>
      _$ServiceCallingPointFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCallingPointToJson(this);
}
