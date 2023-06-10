part of 'diary_display_content_cubit.dart';

abstract class DiaryDisplayContentState {
  const DiaryDisplayContentState();

  @override
  List<Object> get props => [];
}

class DiaryDisplayContentInitial extends DiaryDisplayContentState {}

class DiaryDisplayContentLoading extends DiaryDisplayContentState {}

class DiaryDisplayContentNotFound extends DiaryDisplayContentState {}

class DiaryDisplayContentSuccess extends DiaryDisplayContentState {
  final DiaryDisplayContent content;

  const DiaryDisplayContentSuccess(this.content);

  @override
  List<Object> get props => [content];
}