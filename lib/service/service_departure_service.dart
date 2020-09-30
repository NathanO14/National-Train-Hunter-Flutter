import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/api/service_departure_api.dart';
import 'package:national_train_hunter/model/enums/filter_type.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:national_train_hunter/model/service_information.dart';
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
      numRows: 50,
      crs: crs,
      filterCrs: filterCrs,
      time: DateTime.now().toIso8601String(),
      timeWindow: 60,
      filterType: departing
          ? EnumToString.convertToString(FilterType.TO)
          : EnumToString.convertToString(FilterType.FROM),
    );

    _logger.info("Loading complete.");
    return departures;
  }

  Future<ServiceInformation> getServiceDetails(String rid) async {
    _logger.info("Loading service information for: $rid");

    ServiceInformation serviceInformation =
        await _serviceDepartureAPI.getServiceDetails(rid: rid);

    _logger.info("Loading complete.");
    return serviceInformation;
  }
}
