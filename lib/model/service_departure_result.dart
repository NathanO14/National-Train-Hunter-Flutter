import 'package:json_annotation/json_annotation.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:national_train_hunter/model/service_message.dart';

part 'service_departure_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceDepartureResult {
  List<ServiceDeparture> serviceDepartures;
  List<ServiceMessage> serviceMessages;

  ServiceDepartureResult({
    this.serviceDepartures,
    this.serviceMessages,
  });

  factory ServiceDepartureResult.fromJson(Map<String, dynamic> json) =>
      _$ServiceDepartureResultFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDepartureResultToJson(this);
}
