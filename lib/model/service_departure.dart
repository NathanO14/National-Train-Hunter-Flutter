import 'package:json_annotation/json_annotation.dart';

part 'service_departure.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceDeparture {
  String rid;
  String rsId;
  String serviceID;
  String platform;
  String originStation;
  String destinationStation;
  String via;
  DateTime scheduledDepartureTime;
  DateTime estimatedDepartureTime;
  bool delayed;
  bool cancelled;
  int length;

  ServiceDeparture({
    this.rid,
    this.rsId,
    this.serviceID,
    this.platform,
    this.originStation,
    this.destinationStation,
    this.via,
    this.scheduledDepartureTime,
    this.estimatedDepartureTime,
    this.delayed,
    this.cancelled,
    this.length,
  });

  factory ServiceDeparture.fromJson(Map<String, dynamic> json) =>
      _$ServiceDepartureFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDepartureToJson(this);
}
