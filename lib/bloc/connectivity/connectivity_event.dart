part of 'connectivity_bloc.dart';

class ConnectivityEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class WatchConnectivityEvent extends ConnectivityEvent {}

class CheckConnectivityEvent extends ConnectivityEvent {}
