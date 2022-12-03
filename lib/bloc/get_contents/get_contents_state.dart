part of 'get_contents_bloc.dart';

abstract class GetContentsState extends Equatable {
  const GetContentsState();

  bool get isGettingContentsState => this is GettingContentsState;
  bool get isGettContentsInitialState => this is GetContentsInitialState;
  bool get isGetContentsSucceedState => this is GetContentsSucceedState;
  bool get isGetContentsFailedState => this is GetContentsFailedState;
  bool get isDataEmptyState => this is GetContentsEmptyState;

  GetContentsSucceedState get asSucceedState => this as GetContentsSucceedState;
  GetContentsFailedState get asFailedState => this as GetContentsFailedState;

  String get getContentsError => asFailedState.error;
  List<dynamic> get getContents => asSucceedState.contents;

  @override
  List<Object?> get props => <Object?>[];
}

class GettingContentsState extends GetContentsState {}

class GetContentsInitialState extends GetContentsState {}

class GetContentsEmptyState extends GetContentsState {}

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