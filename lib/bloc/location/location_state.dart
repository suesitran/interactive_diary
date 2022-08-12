part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationServiceDisableState extends LocationState {}

class LocationPermissionNotGrantedState extends LocationState {}

class UnknownLocationErrorState extends LocationState {}

class LocationReadyState extends LocationState {
  final LocationDetails currentLocation;
  final String dateDisplay;

  LocationReadyState(this.currentLocation, this.dateDisplay);
}
