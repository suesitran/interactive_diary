import 'package:hive_flutter/adapters.dart';

import 'package:nartus_storage/src/data/diary.dart';
import 'package:nartus_storage/src/data/user.dart';

part 'hive_adapters.g.dart';

@HiveType(typeId: 0)
class HiveDiary {
  @HiveField(0)
  final int timestamp; // milliseconds since Epoch
  @HiveField(1)
  final String countryCode;
  @HiveField(2)
  final String postalCode;
  @HiveField(3)
  final String addressLine;
  @HiveField(4)
  final HiveLatLng latLng;
  @HiveField(5)
  final String title;
  @HiveField(6, defaultValue: <HiveTextDiary>[])
  final List<HiveTextDiary> textContents;
  @HiveField(7, defaultValue: <HiveImageDiary>[])
  final List<HiveImageDiary> imageContents;
  @HiveField(8, defaultValue: <HiveVideoDiary>[])
  final List<HiveVideoDiary> videoContents;
  @HiveField(9)
  final int update; // milliseconds since Epoch

  HiveDiary(
      {required this.timestamp,
      required this.countryCode,
      required this.postalCode,
      required this.addressLine,
      required this.latLng,
      required this.title,
      required this.textContents,
      required this.imageContents,
      required this.videoContents,
      required this.update});

  HiveDiary.fromDiary(Diary diary)
      : timestamp = diary.timestamp,
        countryCode = diary.countryCode,
        postalCode = diary.postalCode,
        addressLine = diary.addressLine,
        latLng = HiveLatLng(lat: diary.latLng.lat, long: diary.latLng.long),
        title = diary.title,
        textContents = diary.contents
            .whereType<TextDiary>()
            .map((TextDiary e) => HiveTextDiary(description: e.description))
            .toList(),
        imageContents = diary.contents
            .whereType<ImageDiary>()
            .map((ImageDiary e) => HiveImageDiary(
                url: e.url,
                thumbnailUrl: e.thumbnailUrl,
                description: e.description))
            .toList(),
        videoContents = diary.contents
            .whereType<VideoDiary>()
            .map((VideoDiary e) => HiveVideoDiary(
                url: e.url, description: e.description, thumbnail: e.thumbnail))
            .toList(),
        update = diary.update;

  Diary toDiary(String applicationSupportDiary) => Diary(
      timestamp: timestamp,
      countryCode: countryCode,
      postalCode: postalCode,
      addressLine: addressLine,
      latLng: latLng.toLatLng(),
      title: title,
      contents: <Content>[
        if (textContents.isNotEmpty)
          ...textContents.map((HiveTextDiary e) => e.toTextDiary()).toList(),
        if (imageContents.isNotEmpty)
          ...imageContents
              .map(
                  (HiveImageDiary e) => e.toImageDiary(applicationSupportDiary))
              .toList(),
        if (videoContents.isNotEmpty)
          ...videoContents
              .map(
                  (HiveVideoDiary e) => e.toVideoDiary(applicationSupportDiary))
              .toList()
      ],
      update: update);
}

@HiveType(typeId: 1)
class HiveLatLng {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double long;

  const HiveLatLng({required this.lat, required this.long});

  LatLng toLatLng() => LatLng(lat: lat, long: long);
}

@HiveType(typeId: 2)
class HiveTextDiary {
  @HiveField(0)
  final String description;

  HiveTextDiary({required this.description});

  TextDiary toTextDiary() => TextDiary(description: description);
}

@HiveType(typeId: 3)
class HiveImageDiary {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String thumbnailUrl;
  @HiveField(2)
  final String description;

  HiveImageDiary(
      {required this.url,
      required this.thumbnailUrl,
      required this.description});

  ImageDiary toImageDiary(String applicationSupportDiary) => ImageDiary(
      url: '$applicationSupportDiary/$url',
      thumbnailUrl: '$applicationSupportDiary/$thumbnailUrl',
      description: description);
}

@HiveType(typeId: 4)
class HiveVideoDiary {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String thumbnail;

  HiveVideoDiary(
      {required this.url, required this.description, required this.thumbnail});

  VideoDiary toVideoDiary(String applicationSupportDiary) => VideoDiary(
      url: '$applicationSupportDiary/$url',
      description: description,
      thumbnail: '$applicationSupportDiary/$thumbnail');
}

@HiveType(typeId: 5)
class HiveUser {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String? photoUrl;

  const HiveUser(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      this.photoUrl});

  HiveUser.fromUser(User user)
      : uid = user.uid,
        firstName = user.firstName,
        lastName = user.lastName,
        photoUrl = user.photoUrl;

  User toUser() => User(
      uid: uid, firstName: firstName, lastName: lastName, photoUrl: photoUrl);
}
