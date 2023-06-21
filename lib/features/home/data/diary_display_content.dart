class DiaryDisplayContent {
  final String? userDisplayName;
  final DateTime dateTime;
  final String? userPhotoUrl;
  final String? plainText;
  final List<MediaInfo> mediaInfos;
  final String countryCode;
  final String postalCode;

  DiaryDisplayContent({
    required this.dateTime,
    required this.countryCode,
    required this.postalCode,
    this.userDisplayName,
    this.userPhotoUrl,
    this.plainText,
    this.mediaInfos = const [],
  });
}

class MediaInfo {
  final String imageUrl;
  final bool isVideo;

  MediaInfo(this.imageUrl, this.isVideo);
}
