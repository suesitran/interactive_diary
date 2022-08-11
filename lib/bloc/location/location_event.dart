part of 'location_bloc.dart';

abstract class LocationEvent {}

class RequestCurrentLocationEvent extends LocationEvent {}

class RequestLocationServiceEvent extends LocationEvent {}
