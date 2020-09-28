import 'package:json_annotation/json_annotation.dart';
import 'package:national_train_hunter/model/service_calling_point.dart';

part 'service_information.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceInformation {
  String rid;
  String rsId;
  String serviceId;
  String operator;
  String serviceType;
  List<ServiceCallingPoint> callingPoints;

  ServiceInformation({
    this.rid,
    this.rsId,
    this.serviceId,
    this.operator,
    this.serviceType,
    this.callingPoints,
  });

  factory ServiceInformation.fromJson(Map<String, dynamic> json) =>
      _$ServiceInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceInformationToJson(this);
}
