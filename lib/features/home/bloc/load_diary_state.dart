part of 'load_diary_cubit.dart';

abstract class LoadDiaryState {
  const LoadDiaryState();
}

class LoadDiaryInitial extends LoadDiaryState {}

class LoadDiaryCompleted extends LoadDiaryState {
  final List<DiaryDisplayContent> contents;

  const LoadDiaryCompleted(this.contents);
}
