import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/api/station_api.dart';
import 'package:national_train_hunter/model/station.dart';
import 'package:simple_logger/simple_logger.dart';

class StationService {
  final Dio _dio = Dio();
  final SimpleLogger _logger = SimpleLogger();
  StationAPI _stationAPI;

  static final StationService _vehicleService = StationService._internal();

  factory StationService() {
    return _vehicleService;
  }

  StationService._internal() {
    _stationAPI = StationAPI(_dio);
  }

  @visibleForTesting
  void setBaseUrl(String baseUrl) {
    _stationAPI = StationAPI(_dio, baseUrl: baseUrl);
  }

  Future<List<Station>> getStationBySearchTerm(String searchTerm) async {
    _logger.info("Loading stations by search term: $searchTerm");

    List<Station> vehicles =
        await _stationAPI.getStationsBySearchTerm(searchTerm, 0, 20);

    _logger.info("Loading complete.");
    return vehicles;
  }
}
