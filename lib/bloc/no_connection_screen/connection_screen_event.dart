part of 'connection_screen_bloc.dart';

abstract class ConnectionScreenEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class ChangeConnectConnectivityEvent extends ConnectionScreenEvent {}
