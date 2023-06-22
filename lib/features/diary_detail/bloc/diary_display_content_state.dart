part of 'diary_display_content_cubit.dart';

abstract class DiaryDisplayContentState extends Equatable {
  const DiaryDisplayContentState();
}

class DiaryDisplayContentInitial extends DiaryDisplayContentState {
  @override
  List<Object?> get props => [];
}

class DiaryDisplayContentNotFound extends DiaryDisplayContentState {
  @override
  List<Object?> get props => [];
}

abstract class DiaryContentState extends DiaryDisplayContentState {
  final String? displayName;
  final String? photoUrl;
  final DateTime dateTime;

  const DiaryContentState(
      {required this.displayName,
      required this.photoUrl,
      required this.dateTime});
}

class TextDiaryContent extends DiaryContentState {
  final String jsonContent;

  const TextDiaryContent(
      {required this.jsonContent,
      required super.displayName,
      required super.photoUrl,
      required super.dateTime});

  @override
  List<Object?> get props => [jsonContent, displayName, photoUrl];
}

class ImageDiaryContent extends DiaryContentState {
  final String imagePath;

  const ImageDiaryContent(
      {required this.imagePath,
      required super.displayName,
      required super.photoUrl,
      required super.dateTime});

  @override
  List<Object?> get props => [imagePath, displayName, photoUrl];
}

class VideoDiaryContent extends DiaryContentState {
  final String videoPath;

  const VideoDiaryContent(
      {required this.videoPath,
      required super.displayName,
      required super.photoUrl,
      required super.dateTime});

  @override
  List<Object?> get props => [videoPath, displayName, photoUrl];
}
