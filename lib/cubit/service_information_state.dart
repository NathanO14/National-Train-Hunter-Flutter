part of 'service_information_cubit.dart';

abstract class ServiceInformationState extends Equatable {
  const ServiceInformationState();
}

class ServiceInformationInitial extends ServiceInformationState {
  const ServiceInformationInitial();

  @override
  List<Object> get props => [];
}

class ServiceInformationLoading extends ServiceInformationState {
  const ServiceInformationLoading();

  @override
  List<Object> get props => [];
}

class ServiceInformationLoaded extends ServiceInformationState {
  final ServiceInformation serviceInformation;

  const ServiceInformationLoaded(this.serviceInformation);

  @override
  List<Object> get props => [];
}
