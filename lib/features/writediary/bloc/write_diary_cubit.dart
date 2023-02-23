import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'write_diary_state.dart';

class WriteDiaryCubit extends Cubit<WriteDiaryState> {
  late final StorageService service;

  WriteDiaryCubit({StorageService? storageService}) :
        service = storageService ?? StorageService(StorageType.local),
        super(WriteDiaryInitial());

  Future<void> saveTextDiary( {required String title,
    required String textContent,
    required LatLng latLng}
  ) async {
    emit(WriteDiaryStart());

    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    await service.saveDiary(Diary(
        timestamp: timestamp,
        latLng: latLng,
        title: title,
        contents: <Content>[TextDiary(description: textContent)],
        update: timestamp));

    emit(WriteDiarySuccess());
  }
}
