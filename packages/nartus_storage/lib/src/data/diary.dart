class DiaryCollection {
  final String month; // format MMyyyy
  final List<Diary> diaries;

  const DiaryCollection({required this.month, required this.diaries});
}

class LatLng {
  final double lat;
  final double long;

  const LatLng({required this.lat, required this.long});
}

class Diary {
  /// this timestamp is used as key for this diary content, and will never be changed
  final int timestamp; // milliseconds since Epoch
  final String countryCode;
  final String postalCode;
  final String addressLine;
  final LatLng latLng;
  final String title;
  final List<Content> contents;
  // this update timestamp is updated everytime user edit this diary content.
  final int update; // milliseconds since Epoch

  Diary(
      {required this.timestamp,
      required this.countryCode,
      required this.postalCode,
      required this.addressLine,
      required this.latLng,
      required this.title,
      required this.contents,
      required this.update});
}

enum ContentType { text, image, video }

abstract class Content {
  final ContentType type;

  Content({required this.type});
}

class TextDiary extends Content {
  final String description;

  TextDiary({required this.description}) : super(type: ContentType.text);
}

class ImageDiary extends Content {
  final String url;
  final String thumbnailUrl;
  final String description;

  ImageDiary(
      {required this.url,
      required this.thumbnailUrl,
      required this.description})
      : super(type: ContentType.image);
}

class VideoDiary extends Content {
  final String url;
  final String description;
  final String thumbnail;

  VideoDiary(
      {required this.url, required this.description, required this.thumbnail})
      : super(type: ContentType.video);
}
