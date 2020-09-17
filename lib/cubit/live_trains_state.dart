part of 'live_trains_cubit.dart';

abstract class LiveTrainsState extends Equatable {
  const LiveTrainsState();
}

class LiveTrainsInitial extends LiveTrainsState {
  const LiveTrainsInitial();

  @override
  List<Object> get props => [];
}

class LiveTrainsStationsLoading extends LiveTrainsState {
  const LiveTrainsStationsLoading();

  @override
  List<Object> get props => [];
}

class LiveTrainsStationsLoaded extends LiveTrainsState {
  final List<Station> stations;

  const LiveTrainsStationsLoaded(this.stations);

  @override
  List<Object> get props => [];
}
