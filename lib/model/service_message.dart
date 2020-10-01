import 'package:json_annotation/json_annotation.dart';

part 'service_message.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceMessage {
  String category;
  String severity;
  String message;

  ServiceMessage({
    this.category,
    this.severity,
    this.message,
  });

  factory ServiceMessage.fromJson(Map<String, dynamic> json) =>
      _$ServiceMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceMessageToJson(this);
}
