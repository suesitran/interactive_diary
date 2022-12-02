import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  late final StorageService service;

  StorageBloc() : super(StorageInitial()) {
    service = StorageService(StorageType.local);

    // initialise storage service
    on<RequestSaveTextDiaryEvent>(
        (RequestSaveTextDiaryEvent event, Emitter<StorageState> emit) async {
      await _saveTextDiary(event, emit);
    });
  }

  Future<void> _saveTextDiary(
      RequestSaveTextDiaryEvent event, Emitter<StorageState> emit) async {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    await service.saveDiary(Diary(
        timestamp: timestamp,
        latLng: event.latLng,
        title: event.title,
        contents: <Content>[TextDiary(description: event.textContent)],
        update: timestamp));
    emit(StorageSaveTextDiarySuccess(timestamp));
  }
}
