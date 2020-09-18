import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:national_train_hunter/model/service_departure.dart';
import 'package:national_train_hunter/model/station.dart';
import 'package:national_train_hunter/service/service_departure_service.dart';
import 'package:national_train_hunter/service/station_service.dart';

part 'live_trains_state.dart';

class LiveTrainsCubit extends Cubit<LiveTrainsState> {
  final StationService _stationService;
  final ServiceDepartureService _serviceDepartureService;

  LiveTrainsCubit(
    this._stationService,
    this._serviceDepartureService,
  ) : super(LiveTrainsInitial());

  Future<List<Station>> getStationBySearchTerm(String searchTerm) async {
    emit(LiveTrainsStationsLoading());

    final List<Station> results =
        await _stationService.getStationBySearchTerm(searchTerm);

    emit(LiveTrainsStationsLoaded(results));

    return results;
  }

  Future<void> getDepartures(
      String crs, String filterCrs, bool departing) async {
    emit(LiveTrainsLoading());

    final List<ServiceDeparture> results = await _serviceDepartureService
        .getDepartureBoard(crs, filterCrs, departing);

    emit(LiveTrainsLoaded(results));
  }
}
