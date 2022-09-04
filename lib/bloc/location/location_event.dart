part of 'location_bloc.dart';

abstract class LocationEvent {}

class ShowDialogRequestPermissionEvent extends LocationEvent {}

class RequestCurrentLocationEvent extends LocationEvent {
  PermissionStatusDiary status;
  RequestCurrentLocationEvent(this.status);
}

class RequestLocationServiceEvent extends LocationEvent {}

class DefaultLocationEvent extends LocationEvent {}
