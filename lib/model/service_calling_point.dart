import 'package:json_annotation/json_annotation.dart';

part 'service_calling_point.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceCallingPoint {
  String crs;
  String stationName;
  String platform;
  DateTime scheduledArrivalTime;
  DateTime actualArrivalTime;
  DateTime estimatedArrivalTime;
  DateTime scheduledDepartureTime;
  DateTime actualDepartureTime;
  DateTime estimatedDepartureTime;
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
