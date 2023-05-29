import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preview_interaction_state.dart';

class PreviewInteractionCubit extends Cubit<PreviewInteractionState> {
  PreviewInteractionCubit() : super(PreviewInteractionInitial());

  void onCancelPreview(String path) {
    File file = File(path);
    file.deleteSync();

    emit(OnFileDeleted());
  }
}
