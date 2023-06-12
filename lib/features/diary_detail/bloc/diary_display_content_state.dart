part of 'diary_display_content_cubit.dart';

abstract class DiaryDisplayContentState {
  const DiaryDisplayContentState();
}

class DiaryDisplayContentInitial extends DiaryDisplayContentState {}

class DiaryDisplayContentNotFound extends DiaryDisplayContentState {}

class DiaryDisplayContentSuccess extends DiaryDisplayContentState {
  final DiaryDisplayContent content;

  const DiaryDisplayContentSuccess(this.content);

}