import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:national_train_hunter/model/station.dart';
import 'package:national_train_hunter/station_service.dart';

part 'live_trains_state.dart';

class LiveTrainsCubit extends Cubit<LiveTrainsState> {
  final StationService _stationService;

  LiveTrainsCubit(this._stationService) : super(LiveTrainsInitial());

  Future<List<Station>> getStationBySearchTerm(String searchTerm) async {
    emit(LiveTrainsStationsLoading());

    final List<Station> results =
        await _stationService.getStationBySearchTerm(searchTerm);

    emit(LiveTrainsStationsLoaded(results));

    return results;
  }
}
