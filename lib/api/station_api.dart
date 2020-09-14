import 'package:dio/dio.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/model/station.dart';
import 'package:retrofit/retrofit.dart';

part 'station_api.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class StationAPI {
  factory StationAPI(Dio dio, {String baseUrl}) = _StationAPI;

  @GET("/v1/station/search")
  Future<List<Station>> getStationsBySearchTerm(
      @Query("query") String searchTerm,
      @Query("page") int page,
      @Query("pageSize") int pageSize);
}
