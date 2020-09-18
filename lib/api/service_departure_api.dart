import 'package:dio/dio.dart';
import 'package:national_train_hunter/api/params/get_board_request_params.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:retrofit/retrofit.dart';

part 'service_departure_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ServiceDepartureAPI {
  factory ServiceDepartureAPI(Dio dio, {String baseUrl}) = _ServiceDepartureAPI;

  @POST("/v1/service/departureBoard")
  Future<List<ServiceDeparture>> getDepartureBoard(
    @Body() GetBoardRequestParams getBoardRequestParams,
  );
}
