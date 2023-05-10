part of 'diary_detail_cubit.dart';

abstract class DiaryDetailState extends Equatable {
  const DiaryDetailState();

  @override
  List<Object> get props => [];
}

class DiaryDetailInitial extends DiaryDetailState {}

class LoadDiaryDetailCompleted extends DiaryDetailState {
  final DiaryDisplayContent contents;
  final QuillController richText;

  const LoadDiaryDetailCompleted(this.contents, this.richText);
  @override
  List<Object> get props => [contents, richText];
}
