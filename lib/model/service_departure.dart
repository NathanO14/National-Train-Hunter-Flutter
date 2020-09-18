import 'package:json_annotation/json_annotation.dart';

part 'service_departure.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceDeparture {
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

  ServiceDeparture({
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
  });

  factory ServiceDeparture.fromJson(Map<String, dynamic> json) =>
      _$ServiceDepartureFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDepartureToJson(this);
}
