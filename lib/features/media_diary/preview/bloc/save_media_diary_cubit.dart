import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'save_media_diary_state.dart';

class SaveMediaDiaryCubit extends Cubit<SaveMediaDiaryState> {
  final LatLng latLng;
  final String path;
  final MediaType type;

  SaveMediaDiaryCubit(
      {required this.latLng, required this.path, required this.type})
      : super(SaveMediaDiaryInitial());

  void save() async {
    emit(SaveMediaDiaryStart());

    final GeocoderService geocoderService =
        ServiceLocator.instance.get<GeocoderService>();

    final LocationDetail locationDetail =
        await geocoderService.getCurrentPlaceCoding(latLng.lat, latLng.long);

    Content content;

    switch (type) {
      case MediaType.picture:
        content = ImageDiary(url: path, thumbnailUrl: path, description: '');
        break;
      case MediaType.video:
        content = VideoDiary(url: path, description: '');
        break;
    }

    final int timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    Diary diary = Diary(
        timestamp: timestamp,
        countryCode: locationDetail.countryCode ?? 'Unknown',
        postalCode: locationDetail.postalCode ?? 'Unknown',
        addressLine: locationDetail.address,
        latLng: latLng,
        title: '',
        contents: [content],
        update: timestamp);

    final StorageService storageService =
        ServiceLocator.instance.get<StorageService>();

    await storageService.saveDiary(diary);

    emit(SaveMediaDiaryComplete());
  }
}
