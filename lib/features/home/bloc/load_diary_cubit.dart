import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'load_diary_state.dart';

class LoadDiaryCubit extends Cubit<LoadDiaryState> {
  final StorageService storageService =
      ServiceLocator.instance.get<StorageService>();

  LoadDiaryCubit() : super(LoadDiaryInitial());

  void loadDiary(
      {required String? countryCode, required String? postalCode}) async {
    DiaryCollection collection = await storageService.readDiaryForMonth(
        countryCode: countryCode,
        postalCode: postalCode,
        month: DateTime.now());

    List<DiaryDisplayContent> displayContents = [];
    // TODO load user display name and display photo
    String userDisplayName = 'Hoang Nguyen';
    String userPhotoUrl =
        'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';

    for (Diary diary in collection.diaries) {
      String plainText = '';
      List<MediaInfo> mediaInfos =
          []; // at the current version, only support one image, need to update if we support list image

      for (Content content in diary.contents) {
        if (content is TextDiary) {
          final textJson = jsonDecode(content.description);

          Document document = Document.fromJson(textJson);

          plainText += '${document.toPlainText()}\n';
        } else if (content is ImageDiary) {
          mediaInfos.add(MediaInfo(content.thumbnailUrl, false));
        }

        if (content is VideoDiary) {
          mediaInfos.add(MediaInfo(content.thumbnail, true));
        }

        // TODO handle other type

        // add this display content into list
        displayContents.add(DiaryDisplayContent(
          userDisplayName: userDisplayName,
          dateTime: DateTime.fromMillisecondsSinceEpoch(diary.timestamp),
          userPhotoUrl: userPhotoUrl,
          plainText: plainText.trim(),
          mediaInfos: mediaInfos,
          countryCode: diary.countryCode,
          postalCode: diary.postalCode,
        ));
      }
    }

    emit(LoadDiaryCompleted(displayContents));
  }
}
