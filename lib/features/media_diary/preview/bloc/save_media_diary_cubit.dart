import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/features/media_diary/_shared/constant/media_type.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_media/nartus_media.dart';
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

    Content? content;

    switch (type) {
      case MediaType.picture:
        content = ImageDiary(url: path, thumbnailUrl: path, description: '');
        break;
      case MediaType.video:
        final NartusMediaService mediaService = ServiceLocator.instance.get<
            NartusMediaService>();
        try {
          final String thumbnail = await mediaService.createThumbnailForVideo(
              path);
          content =
              VideoDiary(url: path, description: '', thumbnail: thumbnail);
        } on ThumbnailNotCreatedException catch (e) {
          // TODO handle error when failed to create video thumbnail
          print('thumbnail not created ${e.toString()}');
        }
        break;
    }

    if (content != null) {
      final int timestamp = DateTime
          .now()
          .toUtc()
          .millisecondsSinceEpoch;
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
    } else {
      // TODO handle when app failed to save content
    }
  }
}