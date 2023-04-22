class DiaryDisplayContent {
  final String userDisplayName;
  final DateTime dateTime;
  final String? userPhotoUrl;
  final String? plainText;
  final List<String> imageUrl;

  DiaryDisplayContent({
    required this.userDisplayName,
    required this.dateTime,
    this.userPhotoUrl,
    this.plainText,
    this.imageUrl = const []
});
}