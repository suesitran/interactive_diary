part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();
}

class RequestSaveTextDiaryEvent extends StorageEvent {
  final String text;

  const RequestSaveTextDiaryEvent(this.text);

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[text];

}
