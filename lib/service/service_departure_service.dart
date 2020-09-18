import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/api/params/filter_type.dart';
import 'package:national_train_hunter/api/params/get_board_request_params.dart';
import 'package:national_train_hunter/api/service_departure_api.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:simple_logger/simple_logger.dart';

class ServiceDepartureService {
  final Dio _dio = Dio();
  final SimpleLogger _logger = SimpleLogger();
  ServiceDepartureAPI _serviceDepartureAPI;

  static final ServiceDepartureService _serviceDepartureService =
      ServiceDepartureService._internal();

  factory ServiceDepartureService() {
    return _serviceDepartureService;
  }

  ServiceDepartureService._internal() {
    _serviceDepartureAPI = ServiceDepartureAPI(_dio);
  }

  @visibleForTesting
  void setBaseUrl(String baseUrl) {
    _serviceDepartureAPI = ServiceDepartureAPI(_dio, baseUrl: baseUrl);
  }

  Future<List<ServiceDeparture>> getDepartureBoard(
      String crs, String filterCrs, bool departing) async {
    _logger.info(
        "Loading departures between $crs & $filterCrs. Departing: $departing");

    List<ServiceDeparture> departures =
        await _serviceDepartureAPI.getDepartureBoard(
      GetBoardRequestParams(
        crs: crs,
        filterCrs: filterCrs,
        filterType: departing ? FilterType.TO : FilterType.FROM,
      ),
    );

    _logger.info("Loading complete.");
    return departures;
  }
}
