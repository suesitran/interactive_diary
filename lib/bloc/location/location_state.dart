part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationServiceDisableState extends LocationState {}

class LocationReadyState extends LocationState {
  final LocationDetails currentLocation;

  LocationReadyState(this.currentLocation);
}
