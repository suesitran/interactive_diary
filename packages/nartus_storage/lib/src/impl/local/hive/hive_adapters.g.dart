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
      latLng: fields[1] as HiveLatLng,
      title: fields[2] as String,
      textContents:
          fields[3] == null ? [] : (fields[3] as List).cast<HiveTextDiary>(),
      imageContents:
          fields[4] == null ? [] : (fields[4] as List).cast<HiveImageDiary>(),
      videoContents:
          fields[5] == null ? [] : (fields[5] as List).cast<HiveVideoDiary>(),
      update: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDiary obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.latLng)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.textContents)
      ..writeByte(4)
      ..write(obj.imageContents)
      ..writeByte(5)
      ..write(obj.videoContents)
      ..writeByte(6)
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
    );
  }

  @override
  void write(BinaryWriter writer, HiveVideoDiary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.description);
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
