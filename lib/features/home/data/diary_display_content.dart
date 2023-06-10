class DiaryDisplayContent {
  final String userDisplayName;
  final DateTime dateTime;
  final String userPhotoUrl;
  final String? plainText;
  final List<String> imageUrl;
  final String countryCode;
  final String postalCode;

  DiaryDisplayContent({
    required this.userDisplayName,
    required this.dateTime,
    required this.userPhotoUrl,
    required this.countryCode,
    required this.postalCode,
    this.plainText,
    this.imageUrl = const [],
  });
}
