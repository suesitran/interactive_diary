import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_authentication/nartus_authentication.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'load_diary_state.dart';

class LoadDiaryCubit extends Cubit<LoadDiaryState> {
  final StorageService storageService =
      ServiceLocator.instance.get<StorageService>();

  final AuthenticationService authenticationService =
      ServiceLocator.instance.get<AuthenticationService>();

  LoadDiaryCubit() : super(LoadDiaryInitial());

  void loadDiary(
      {required String? countryCode, required String? postalCode}) async {
    String? displayName;
    String? photoUrl;
    try {
      UserDetail userDetail = await authenticationService.getCurrentUser();

      displayName = userDetail.name;
      photoUrl = userDetail.avatarUrl;
    } catch (e) {
      // dothing
    }

    DiaryCollection collection = await storageService.readDiaryForMonth(
        countryCode: countryCode,
        postalCode: postalCode,
        month: DateTime.now());

    List<DiaryDisplayContent> displayContents = [];

    for (Diary diary in collection.diaries) {
      String plainText = '';
      // at the current version, only support one image, need to update if we support list image
      List<MediaInfo> mediaInfos = [];

      for (Content content in diary.contents) {
        if (content is TextDiary) {
          final textJson = jsonDecode(content.description);

          Document document = Document.fromJson(textJson);

          plainText += '${document.toPlainText()}\n';
        }

        if (content is ImageDiary) {
          mediaInfos.add(MediaInfo(content.thumbnailUrl, false));
        }

        if (content is VideoDiary) {
          mediaInfos.add(MediaInfo(content.thumbnail, true));
        }

        // add this display content into list
        displayContents.add(DiaryDisplayContent(
            userDisplayName: displayName,
            dateTime:
                DateTime.fromMillisecondsSinceEpoch(diary.timestamp).toLocal(),
            userPhotoUrl: photoUrl,
            mediaInfos: mediaInfos,
            countryCode: diary.countryCode,
            postalCode: diary.postalCode,
            plainText: plainText));
      }
    }

    emit(LoadDiaryCompleted(displayContents));
  }
}
