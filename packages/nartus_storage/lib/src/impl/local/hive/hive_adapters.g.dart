// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDiaryAdapter extends TypeAdapter<HiveDiary> {
  @override
  final int typeId = 0;

  @override
  HiveDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDiary(
      timestamp: fields[0] as int,
      countryCode: fields[1] as String,
      postalCode: fields[2] as String,
      addressLine: fields[3] as String,
      latLng: fields[4] as HiveLatLng,
      title: fields[5] as String,
      textContents:
          fields[6] == null ? [] : (fields[6] as List).cast<HiveTextDiary>(),
      imageContents:
          fields[7] == null ? [] : (fields[7] as List).cast<HiveImageDiary>(),
      videoContents:
          fields[8] == null ? [] : (fields[8] as List).cast<HiveVideoDiary>(),
      update: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDiary obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.countryCode)
      ..writeByte(2)
      ..write(obj.postalCode)
      ..writeByte(3)
      ..write(obj.addressLine)
      ..writeByte(4)
      ..write(obj.latLng)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.textContents)
      ..writeByte(7)
      ..write(obj.imageContents)
      ..writeByte(8)
      ..write(obj.videoContents)
      ..writeByte(9)
      ..write(obj.update);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveLatLngAdapter extends TypeAdapter<HiveLatLng> {
  @override
  final int typeId = 1;

  @override
  HiveLatLng read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLatLng(
      lat: fields[0] as double,
      long: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLatLng obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLatLngAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveTextDiaryAdapter extends TypeAdapter<HiveTextDiary> {
  @override
  final int typeId = 2;

  @override
  HiveTextDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTextDiary(
      description: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveTextDiary obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveTextDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveImageDiaryAdapter extends TypeAdapter<HiveImageDiary> {
  @override
  final int typeId = 3;

  @override
  HiveImageDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveImageDiary(
      url: fields[0] as String,
      thumbnailUrl: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveImageDiary obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.thumbnailUrl)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveImageDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveVideoDiaryAdapter extends TypeAdapter<HiveVideoDiary> {
  @override
  final int typeId = 4;

  @override
  HiveVideoDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveVideoDiary(
      url: fields[0] as String,
      description: fields[1] as String,
      thumbnail: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveVideoDiary obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveVideoDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveUserAdapter extends TypeAdapter<HiveUser> {
  @override
  final int typeId = 5;

  @override
  HiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUser(
      uid: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      photoUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
