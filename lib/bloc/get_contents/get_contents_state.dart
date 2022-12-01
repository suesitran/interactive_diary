part of 'get_contents_bloc.dart';

abstract class GetContentsState extends Equatable {
  const GetContentsState();
  @override
  List<Object?> get props => <Object?>[];
}

class GettingContentsState extends GetContentsState {}

class GetContentsInitialState extends GetContentsState {}

class GetContentsSucceedState extends GetContentsState {
  final List<dynamic> contents;
  const GetContentsSucceedState(this.contents);
  @override
  List<Object?> get props => <Object?>[contents];
}

class GetContentsFailedState extends GetContentsState {
  final String error;
  const GetContentsFailedState(this.error);
  @override
  List<Object?> get props => <Object?>[error];
}