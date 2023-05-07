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

  void loadDiary() async {
    DiaryCollection collection =
        await storageService.readDiaryForMonth(DateTime.now());

    List<DiaryDisplayContent> displayContents = [];
    // TODO load user display name and display photo
    String userDisplayName = 'Hoang Nguyen';
    String userPhotoUrl =
        'https://lh3.googleusercontent.com/a-/AOh14GikSAp8pgWShabZgY2Pw99zzvtz5A9WpVjmqZY7=s96-c';

    for (Diary diary in collection.diaries) {
      String plainText = '';
      Document? document;
      for (Content content in diary.contents) {
        if (content is TextDiary) {
          print('print ${content.description}');
          final textJson = jsonDecode(content.description);
          document = Document.fromJson(textJson);
          plainText += '${document.toPlainText()}\n';
        }

        // TODO handle other type

        // add this display content into list
        displayContents.add(DiaryDisplayContent(
            userDisplayName: userDisplayName,
            dateTime: DateTime.fromMillisecondsSinceEpoch(diary.timestamp),
            userPhotoUrl: userPhotoUrl,
            plainText: plainText.trim(),
            document: document));
      }
    }

    emit(LoadDiaryCompleted(displayContents));
  }
}
