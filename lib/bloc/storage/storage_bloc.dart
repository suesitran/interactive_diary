import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageInitial()) {
    on<RequestSaveTextDiaryEvent>((RequestSaveTextDiaryEvent event, Emitter<StorageState> emit) async {
      await _saveTextDiary(event.text, emit);
    });
  }

  Future<void> _saveTextDiary(String text, Emitter<StorageState> emit) async {
    await Future.delayed(Duration(milliseconds: 100));

    emit(StorageSaveTextDiarySuccess());
  }
}
