import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'diary_display_content_state.dart';

class DiaryDisplayContentCubit extends Cubit<DiaryDisplayContentState> {
  final StorageService storageService =
      ServiceLocator.instance.get<StorageService>();

  DiaryDisplayContentCubit() : super(DiaryDisplayContentInitial());

  void fetchDiaryDisplayContent(
      DateTime dateTime, String countryCode, String postalCode) async {
    Diary? diary = await storageService.getDiary(
        dateTime: dateTime, countryCode: countryCode, postalCode: postalCode);

    if (diary == null) {
      emit(DiaryDisplayContentNotFound());
    } else {
      final DateTime timestamp =
          DateTime.fromMillisecondsSinceEpoch(diary.timestamp).toLocal();

      for (Content content in diary.contents) {
        if (content is TextDiary) {
          emit(TextDiaryContent(
              jsonContent: content.description,
              displayName: null,
              photoUrl: null,
              dateTime: timestamp));
        } else if (content is ImageDiary) {
          emit(ImageDiaryContent(
              imagePath: content.url,
              displayName: null,
              photoUrl: null,
              dateTime: timestamp));
        } else if (content is VideoDiary) {
          emit(VideoDiaryContent(
              videoPath: content.url,
              displayName: null,
              photoUrl: null,
              dateTime: timestamp));
        }

        // emit(DiaryDisplayContentSuccess(DiaryDisplayContent(
        //     userDisplayName: null,
        //     dateTime: DateTime.fromMillisecondsSinceEpoch(diary.timestamp),
        //     userPhotoUrl: null,
        //     plainText: plainText.trim(),
        //     imageUrl: [imageUrl],
        //     countryCode: diary.countryCode,
        //     postalCode: diary.postalCode)));
        //
        // break; // currently the diary only have one content: text/image/video
      }
    }
  }
}
