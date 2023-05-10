import 'package:flutter_quill/flutter_quill.dart';

class DiaryDisplayContent {
  final String userDisplayName;
  final DateTime dateTime;
  final String userPhotoUrl;
  final String? plainText;
  final List<String> imageUrl;

  DiaryDisplayContent({
    required this.userDisplayName,
    required this.dateTime,
    required this.userPhotoUrl,
    this.plainText,
    this.imageUrl = const [],
  });
}
