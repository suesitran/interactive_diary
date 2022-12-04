part of 'connection_screen_bloc.dart';

abstract class ConnectionScreenState extends Equatable {
  const ConnectionScreenState();

  @override
  List<Object> get props => [];
}

class ConnectionScreenInitial extends ConnectionScreenState {}

class ChangeConnectedState extends ConnectionScreenState {}

class ChangeDisonnectedState extends ConnectionScreenState {}
