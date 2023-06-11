import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_storage/nartus_storage.dart';

part 'diary_display_content_state.dart';

class DiaryDisplayContentCubit extends Cubit<DiaryDisplayContentState> {

  final StorageService storageService = ServiceLocator.instance.get<StorageService>();

  DiaryDisplayContentCubit() : super(DiaryDisplayContentInitial());

  void fetchDiaryDisplayContent(String dateTime, String countryCode, String postalCode) async {

    emit(DiaryDisplayContentLoading());
    // String userDisplayName = 'Hoang Nguyen';
    // String userPhotoUrl = 'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';

    Diary? diary = await storageService.getDiary(
        dateTime: dateTime,
        countryCode: countryCode,
        postalCode: postalCode,
        month: DateTime.now());

    if (diary == null) {
      emit(DiaryDisplayContentNotFound());
    } else {
      String plainText = '';
      String imageUrl = '';

      for (Content content in diary.contents) {
        if (content is TextDiary) {
          final textJson = jsonDecode(content.description);
          Document document = Document.fromJson(textJson);
          plainText = '${document.toPlainText()}\n';
        } else if (content is ImageDiary) {
          imageUrl = content.thumbnailUrl;
          plainText = content.description;
        } else if (content is VideoDiary) {
          // todo
        }

        emit(DiaryDisplayContentSuccess(DiaryDisplayContent(
            userDisplayName: '',
            dateTime: DateTime.fromMillisecondsSinceEpoch(diary.timestamp),
            userPhotoUrl: '',
            plainText: plainText.trim(),
            imageUrl: [imageUrl],
            countryCode: diary.countryCode,
            postalCode: diary.postalCode)));

        break; // currently the diary only have one content: text/image/video
      }

    }
  }
}