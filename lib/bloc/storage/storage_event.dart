part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();
}

class RequestSaveTextDiaryEvent extends StorageEvent {
  final String title;
  final String textContent;
  final LatLng latLng;

  const RequestSaveTextDiaryEvent(
      {required this.title, required this.textContent, required this.latLng});

  @override
  List<Object?> get props =>
      <Object?>[title, textContent, latLng.lat, latLng.long];
}
