part of 'save_media_diary_cubit.dart';

abstract class SaveMediaDiaryState extends Equatable {
  const SaveMediaDiaryState();
}

class SaveMediaDiaryInitial extends SaveMediaDiaryState {
  @override
  List<Object> get props => [];
}

class SaveMediaDiaryStart extends SaveMediaDiaryState {
  @override
  List<Object?> get props => [];
}

class SaveMediaDiaryComplete extends SaveMediaDiaryState {
  @override
  List<Object?> get props => [];
}
