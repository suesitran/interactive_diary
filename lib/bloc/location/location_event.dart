part of 'location_bloc.dart';

abstract class LocationEvent {}


class RequestPermissionLocationEvent extends LocationEvent {}

class RequestCurrentLocationEvent extends LocationEvent {}

class RequestLocationServiceEvent extends LocationEvent {}

class DefaultLocationServiceEvent extends LocationEvent {}
