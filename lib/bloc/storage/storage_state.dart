part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => <Object>[];
}

class StorageInitial extends StorageState {}

class StorageSaveTextDiarySuccess extends StorageState {
  final int timestamp;

  const StorageSaveTextDiarySuccess(this.timestamp);

  @override
  List<Object> get props => [timestamp];
}

class StorageSaveTextDiaryFail extends StorageState {}
