import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';

part 'write_diary_state.dart';

class WriteDiaryCubit extends Cubit<WriteDiaryState> {
  final StorageService service = ServiceLocator.instance<StorageService>();
  final GeocoderService _geocoderService =
      ServiceLocator.instance<GeocoderService>();

  WriteDiaryCubit() : super(WriteDiaryInitial());

  Future<void> saveTextDiary(
      {required String title,
      required String textContent,
      required LatLng latLng}) async {
    emit(WriteDiaryStart());

    final int timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;

    final LocationDetail detail =
        await _geocoderService.getCurrentPlaceCoding(latLng.lat, latLng.long);
    await service.saveDiary(Diary(
        timestamp: timestamp,
        countryCode: detail.countryCode ?? 'Unknown',
        postalCode: detail.postalCode ?? 'Unknown',
        addressLine: detail.address,
        latLng: latLng,
        title: title,
        contents: <Content>[TextDiary(description: textContent)],
        update: timestamp));

    emit(WriteDiarySuccess());
  }
}
