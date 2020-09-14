import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable(explicitToJson: true)
class Station {
  String stationCode;
  String stationName;

  Station({
    this.stationCode,
    this.stationName,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);
}
