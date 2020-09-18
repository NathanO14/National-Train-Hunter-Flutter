import 'package:json_annotation/json_annotation.dart';
import 'package:national_train_hunter/api/params/filter_type.dart';

part 'get_board_request_params.g.dart';

@JsonSerializable(explicitToJson: true)
class GetBoardRequestParams {
  int numRows;
  String crs;
  String filterCrs;
  FilterType filterType;
  int timeOffset;
  int timeWindow;

  GetBoardRequestParams({
    this.numRows,
    this.crs,
    this.filterCrs,
    this.filterType,
    this.timeOffset,
    this.timeWindow,
  });

  factory GetBoardRequestParams.fromJson(Map<String, dynamic> json) =>
      _$GetBoardRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBoardRequestParamsToJson(this);
}
