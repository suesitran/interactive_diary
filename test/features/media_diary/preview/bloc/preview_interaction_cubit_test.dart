import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:interactive_diary/features/media_diary/preview/bloc/preview_interaction_cubit.dart';

void main() {
  blocTest(
    'given file does not exist, when cancel preview, then do nothing',
    build: () => PreviewInteractionCubit(),
    act: (bloc) => bloc.onCancelPreview('path'),
    expect: () => [isA<OnFileDeleted>()],
    verify: (bloc) {
      File file = File('path');
      expect(file.existsSync(), isFalse);
    },
  );

  blocTest(
    'given file exists, when cancel preview, then delete file',
    build: () => PreviewInteractionCubit(),
    act: (bloc) => bloc.onCancelPreview('path'),
    setUp: () {
      File file = File('path');
      file.createSync();
      // confirm that file exist
      expect(file.existsSync(), isTrue);
    },
    expect: () => [isA<OnFileDeleted>()],
    verify: (bloc) {
      File file = File('path');
      // confirm file is deleted after run
      expect(file.existsSync(), isFalse);
    },
  );
}
