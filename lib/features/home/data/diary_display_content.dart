class DiaryDisplayContent {
  final String? userDisplayName;
  final DateTime dateTime;
  final String? userPhotoUrl;
  final String? plainText;
  final List<String> imageUrl;
  final String countryCode;
  final String postalCode;

  DiaryDisplayContent({
    required this.dateTime,
    required this.countryCode,
    required this.postalCode,
    this.userDisplayName,
    this.userPhotoUrl,
    this.plainText,
    this.imageUrl = const [],
  });
}
