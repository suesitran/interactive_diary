part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowDialogRequestPermissionEvent extends LocationEvent {}

class OpenAppSettingsEvent extends LocationEvent {}

class RequestCurrentLocationEvent extends LocationEvent {
  RequestCurrentLocationEvent();
}

class RequestLocationServiceEvent extends LocationEvent {}

class RequestDefaultLocationEvent extends LocationEvent {}

class ReturnedFromAppSettingsEvent extends LocationEvent {}
