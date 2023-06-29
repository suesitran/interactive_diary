import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/features/home/widgets/constants/map_svgs.dart';

const String menuCameraMarkerLocationId = 'menuCameraMarkerLocationId';
const String menuPencilMarkerLocationId = 'menuPencilMarkerLocationId';
const String menuEmojiMarkerLocationId = 'menuEmojiMarkerLocationId';
const String menuVoiceMarkerLocationId = 'menuVoiceMarkerLocationId';
const String baseMarkerCurrentLocationId = 'currentLocationId';

class MapMarkerGenerator {
  LatLng? currentLocation;
  final VoidCallback onCurrentLocationMarkerTapped;
  final VoidCallback onCameraTapped;
  final VoidCallback onPenTapped;
  final VoidCallback onMicTapped;
  final VoidCallback onSmileyTapped;

  MapMarkerGenerator(
      {required this.onCurrentLocationMarkerTapped,
      required this.onCameraTapped,
      required this.onPenTapped,
      required this.onMicTapped,
      required this.onSmileyTapped});
  final Set<Marker> _markers = <Marker>{};
  late final StreamController<Set<Marker>> _streamController =
      StreamController<Set<Marker>>.broadcast();

  late final Stream<Set<Marker>> _markerData = _streamController.stream;

  Stream<Set<Marker>> get markerData => _markerData;

  Offset cameraMenuPosition = Offset.zero;
  Offset penMenuPosition = Offset.zero;
  Offset micMenuPosition = Offset.zero;
  Offset smileyMenuPosition = Offset.zero;
  bool showMenu = false;

  bool initialised = false;

  void setup(LatLng currentLocation) async {
    this.currentLocation = currentLocation;

    if (!initialised) {
      initialised = true;
      await _generateMarkerIcon();
    }

    if (this.currentLocation != null) {
      await _computeMarker();
      _generateCircularMenuIcons();
    }
  }

  void onAnimation(
      {required double animValue,
      required Offset cameraMenuPosition,
      required Offset penMenuPosition,
      required Offset micMenuPosition,
      required Offset smileyMenuPosition,
      required bool showMenu}) {
    this.cameraMenuPosition = cameraMenuPosition;
    this.penMenuPosition = penMenuPosition;
    this.micMenuPosition = micMenuPosition;
    this.smileyMenuPosition = smileyMenuPosition;
    this.showMenu = showMenu;

    _computeMarker(angleInDegree: animValue * 45)
        .then((_) => _generateCircularMenuIcons());
  }

  void dispose() {
    _markerAddDrawableRoot?.picture.dispose();
    _baseMarkerDrawableRoot?.picture.dispose();

    _streamController.close();
  }

  // region private helper
  // to draw marker with animation
  PictureInfo? _baseMarkerDrawableRoot;
  PictureInfo? _markerAddDrawableRoot;

  late final BitmapDescriptor _penMarkerBitmap;
  late final BitmapDescriptor _emojiMarkerBitmap;
  late final BitmapDescriptor _cameraMarkerBitmap;
  late final BitmapDescriptor _voiceMarkerBitmap;

  // generate marker base drawable from SVG asset
  Future<PictureInfo> _createDrawableRoot(String svgContent) async {
    // load the base marker svg string from asset
    // load the base marker from svg
    return vg.loadPicture(SvgStringLoader(svgContent), null);
  }

  Future<void> _generateMarkerIcon() async {
    _baseMarkerDrawableRoot = await _createDrawableRoot(markerBaseSvg);
    _markerAddDrawableRoot = await _createDrawableRoot(markerAdd);
    _penMarkerBitmap = await _createDrawableRoot(idCircularIconPencil)
        .then((PictureInfo value) => _computeMenuMarker(value));
    _emojiMarkerBitmap = await _createDrawableRoot(idCircularIconEmoji)
        .then((PictureInfo value) => _computeMenuMarker(value));
    _cameraMarkerBitmap = await _createDrawableRoot(idCircularIconCamera)
        .then((PictureInfo value) => _computeMenuMarker(value));
    _voiceMarkerBitmap = await _createDrawableRoot(idCircularIconMicro)
        .then((PictureInfo value) => _computeMenuMarker(value));
  }

  Future<BitmapDescriptor> _computeMenuMarker(PictureInfo drawableRoot) async {
    const double markerSize = 300;

    // create canvas to draw
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    // draw baseMarker on canvas
    canvas.save();
    canvas.scale(markerSize / drawableRoot.size.width);
    canvas.drawPicture(drawableRoot.picture);
    canvas.restore();

    final ByteData? pngBytes = await (await recorder
            .endRecording()
            .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    // dispose picture after use
    drawableRoot.picture.dispose();

    if (pngBytes != null) {
      return BitmapDescriptor.fromBytes(Uint8List.view(pngBytes.buffer));
    }

    return BitmapDescriptor.defaultMarker;
  }

  // draw complete marker with angle
  Future<void> _computeMarker(
      {double angleInDegree = 0, double markerSize = 150.0}) async {
    // create canvas to draw
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), Offset(markerSize, markerSize)));

    // draw baseMarker on canvas
    canvas.save();
    // calculate max scale by height
    final double height = _baseMarkerDrawableRoot?.size.height ?? 0.0;
    final double scale = height > 0 ? markerSize / height : 0.0;
    canvas.scale(scale, scale);
    final Picture? picture = _baseMarkerDrawableRoot?.picture;
    if (picture != null) {
      canvas.drawPicture(picture);
    }
    canvas.restore();

    // draw marker add
    // translate to desired location on canvas
    final double baseWidth = _baseMarkerDrawableRoot?.size.width ?? 0.0;
    // 3 quarter of base marker
    final double markerAddSize = baseWidth * scale * 3 / 4;
    final double newPos = (markerSize - markerAddSize) / 4;
    canvas.translate(newPos, newPos);

    if (angleInDegree % 90 != 0) {
      // convert angle in degree to radiant
      final double angle = angleInDegree * pi / 180;

      // lock canvas - prepare to draw marker add with desired rotation
      // only do this if angle is not a power of 90
      canvas.save();
      final double r =
          sqrt(markerAddSize * markerAddSize + markerAddSize * markerAddSize) /
              2;
      final double alpha = atan(markerAddSize / markerAddSize);
      final double beta = alpha + angle;
      final double shiftY = r * sin(beta);
      final double shiftX = r * cos(beta);
      final double translateX = markerAddSize / 2 - shiftX;
      final double translateY = markerAddSize / 2 - shiftY;
      canvas.translate(translateX, translateY);
      canvas.rotate(angle);

      final double plusWidth = _markerAddDrawableRoot?.size.width ?? 0.0;
      final double plusHeight = _markerAddDrawableRoot?.size.height ?? 0.0;
      if (plusWidth > 0 && plusHeight > 0) {
        canvas.scale(markerAddSize / plusWidth, markerAddSize / plusHeight);
        final Picture? plusPicture = _markerAddDrawableRoot?.picture;
        if (plusPicture != null) {
          canvas.drawPicture(plusPicture);
        }
      }

      // unlock canvas
      canvas.restore();
    } else {
      // do normal drawing
      canvas.save();
      final double plusWidth = _markerAddDrawableRoot?.size.width ?? 0.0;
      final double plusHeight = _markerAddDrawableRoot?.size.height ?? 0.0;
      if (plusWidth > 0 && plusHeight > 0) {
        canvas.scale(markerAddSize / plusWidth, markerAddSize / plusHeight);
        final Picture? plusPicture = _markerAddDrawableRoot?.picture;
        if (plusPicture != null) {
          canvas.drawPicture(plusPicture);
        }
      }

      canvas.restore();
    }

    final ByteData? pngBytes = await (await recorder
            .endRecording()
            .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      if (!_streamController.isClosed) {
        _markers.clear();
        _markers.add(Marker(
            markerId: const MarkerId(baseMarkerCurrentLocationId),
            position: LatLng(currentLocation?.latitude ?? 0.0,
                currentLocation?.longitude ?? 0.0),
            icon: BitmapDescriptor.fromBytes(Uint8List.view(pngBytes.buffer)),
            zIndex: 1,
            onTap: () {
              onCurrentLocationMarkerTapped();
            }));
      }
    }
  }

  void _generateCircularMenuIcons() {
    final Marker baseCurrentLocation = _markers.firstWhere(
      (element) => element.markerId.value == baseMarkerCurrentLocationId,
      orElse: () {
        // default marker without customise image
        return Marker(
            markerId: const MarkerId(baseMarkerCurrentLocationId),
            position: LatLng(currentLocation?.latitude ?? 0.0,
                currentLocation?.longitude ?? 0.0),
            zIndex: 1,
            onTap: () {
              onCurrentLocationMarkerTapped();
            });
      },
    );
    _markers.clear();
    _markers.add(baseCurrentLocation);

    if (showMenu) {
      _markers.addAll(<Marker>{
        Marker(
            markerId: const MarkerId(menuCameraMarkerLocationId),
            position: currentLocation!,
            icon: _cameraMarkerBitmap,
            anchor: cameraMenuPosition,
            onTap: onCameraTapped),
        Marker(
            markerId: const MarkerId(menuPencilMarkerLocationId),
            position: currentLocation!,
            icon: _penMarkerBitmap,
            anchor: penMenuPosition,
            onTap: onPenTapped),
        Marker(
            markerId: const MarkerId(menuEmojiMarkerLocationId),
            position: currentLocation!,
            icon: _emojiMarkerBitmap,
            anchor: smileyMenuPosition,
            onTap: onSmileyTapped),
        Marker(
            markerId: const MarkerId(menuVoiceMarkerLocationId),
            position: currentLocation!,
            icon: _voiceMarkerBitmap,
            anchor: micMenuPosition,
            onTap: onMicTapped),
      });
    }
    _streamController.sink.add(_markers);
  }
  // endregion
}
