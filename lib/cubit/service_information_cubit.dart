import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:national_train_hunter/model/service_information.dart';
import 'package:national_train_hunter/service/service_departure_service.dart';

part 'service_information_state.dart';

class ServiceInformationCubit extends Cubit<ServiceInformationState> {
  final ServiceDepartureService _serviceDepartureService;

  ServiceInformationCubit(
    this._serviceDepartureService,
  ) : super(ServiceInformationInitial());

  Future<void> getServiceDetails(String rid) async {
    emit(ServiceInformationLoading());

    final ServiceInformation serviceInformation =
        await _serviceDepartureService.getServiceDetails(rid);

    emit(ServiceInformationLoaded(serviceInformation));
  }
}
