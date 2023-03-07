part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class LocationInitial extends LocationState {
  final PermissionStatusDiary status;
  LocationInitial(this.status);

  @override
  List<PermissionStatusDiary> get props => <PermissionStatusDiary>[status];
}

class LocationServiceDisableState extends LocationState {}

class LocationPermissionDeniedState extends LocationState {}

class LocationPermissionDeniedForeverState extends LocationState {}

class AwaitLocationPermissionFromAppSettingState extends LocationState {}

class AwaitLocationServiceSettingState extends LocationState {}

class UnknownLocationErrorState extends LocationState {}

class LocationReadyState extends LocationState {
  final LatLng currentLocation;
  final Placemark? infoLocation;
  final String dateDisplay;

  LocationReadyState(this.currentLocation, this.dateDisplay, this.infoLocation);
}
