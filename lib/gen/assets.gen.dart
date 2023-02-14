/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/anonymous.svg
  String get anonymous => 'assets/images/anonymous.svg';

  /// File path: assets/images/arrow_down.svg
  String get arrowDown => 'assets/images/arrow_down.svg';

  /// File path: assets/images/back.svg
  String get back => 'assets/images/back.svg';

  /// File path: assets/images/calendar.svg
  String get calendar => 'assets/images/calendar.svg';

  /// File path: assets/images/id_camera_icon.svg
  String get idCameraIcon => 'assets/images/id_camera_icon.svg';

  /// File path: assets/images/id_circular_icon_camera.svg
  String get idCircularIconCamera =>
      'assets/images/id_circular_icon_camera.svg';

  /// File path: assets/images/id_circular_icon_emoji.svg
  String get idCircularIconEmoji => 'assets/images/id_circular_icon_emoji.svg';

  /// File path: assets/images/id_circular_icon_micro.svg
  String get idCircularIconMicro => 'assets/images/id_circular_icon_micro.svg';

  /// File path: assets/images/id_circular_icon_pencil.svg
  String get idCircularIconPencil =>
      'assets/images/id_circular_icon_pencil.svg';

  /// File path: assets/images/id_heart_icon_padding.svg
  String get idHeartIconPadding => 'assets/images/id_heart_icon_padding.svg';

  /// File path: assets/images/id_location_icon.svg
  String get idLocationIcon => 'assets/images/id_location_icon.svg';

  /// File path: assets/images/id_location_img.svg
  String get idLocationImg => 'assets/images/id_location_img.svg';

  /// File path: assets/images/id_location_marker_icon.svg
  String get idLocationMarkerIcon =>
      'assets/images/id_location_marker_icon.svg';

  /// File path: assets/images/id_message_icon_padding.svg
  String get idMessageIconPadding =>
      'assets/images/id_message_icon_padding.svg';

  /// File path: assets/images/id_micro_icon.svg
  String get idMicroIcon => 'assets/images/id_micro_icon.svg';

  /// File path: assets/images/id_more_icon.svg
  String get idMoreIcon => 'assets/images/id_more_icon.svg';

  /// File path: assets/images/id_pencil_icon.svg
  String get idPencilIcon => 'assets/images/id_pencil_icon.svg';

  /// File path: assets/images/id_profile_user_icon_padding.svg
  String get idProfileUserIconPadding =>
      'assets/images/id_profile_user_icon_padding.svg';

  /// File path: assets/images/id_share_icon_padding.svg
  String get idShareIconPadding => 'assets/images/id_share_icon_padding.svg';

  /// File path: assets/images/id_smile_icon.svg
  String get idSmileIcon => 'assets/images/id_smile_icon.svg';

  /// File path: assets/images/marker_add.svg
  String get markerAdd => 'assets/images/marker_add.svg';

  /// File path: assets/images/marker_base.svg
  String get markerBase => 'assets/images/marker_base.svg';

  /// File path: assets/images/marker_nonetap.png
  AssetGenImage get markerNonetap =>
      const AssetGenImage('assets/images/marker_nonetap.png');

  /// File path: assets/images/marker_ontap.png
  AssetGenImage get markerOntap =>
      const AssetGenImage('assets/images/marker_ontap.png');

  /// File path: assets/images/no_connection.svg
  String get noConnection => 'assets/images/no_connection.svg';

  /// List of all assets
  List<dynamic> get values => [
        anonymous,
        arrowDown,
        back,
        calendar,
        idCameraIcon,
        idCircularIconCamera,
        idCircularIconEmoji,
        idCircularIconMicro,
        idCircularIconPencil,
        idHeartIconPadding,
        idLocationIcon,
        idLocationImg,
        idLocationMarkerIcon,
        idMessageIconPadding,
        idMicroIcon,
        idMoreIcon,
        idPencilIcon,
        idProfileUserIconPadding,
        idShareIconPadding,
        idSmileIcon,
        markerAdd,
        markerBase,
        markerNonetap,
        markerOntap,
        noConnection
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
