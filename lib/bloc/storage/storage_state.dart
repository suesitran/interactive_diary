part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageInitial extends StorageState {}

class StorageSaveTextDiarySuccess extends StorageState {}

class StorageSaveTextDiaryFail extends StorageState {}
