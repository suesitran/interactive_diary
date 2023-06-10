import 'package:equatable/equatable.dart';
import 'package:interactive_diary/features/home/data/diary_display_content.dart';

abstract class DiaryDisplayContentState extends Equatable {
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