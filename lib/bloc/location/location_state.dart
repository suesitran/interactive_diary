part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {
  PermissionStatusDiary status;
  LocationInitial(this.status);
}

class LocationServiceDisableState extends LocationState {}

class LocationPermissionNotGrantedState extends LocationState {
  PermissionStatusDiary status;
  LocationPermissionNotGrantedState(this.status);
}

class UnknownLocationErrorState extends LocationState {}

class LocationReadyState extends LocationState {
  final LocationDetails currentLocation;
  final String dateDisplay;

  LocationReadyState(this.currentLocation, this.dateDisplay);
}
