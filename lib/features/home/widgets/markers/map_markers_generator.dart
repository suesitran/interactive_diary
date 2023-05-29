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
  final LatLng currentLocation;
  final VoidCallback onCurrentLocationMarkerTapped;
  final VoidCallback onCameraTapped;
  final VoidCallback onPenTapped;
  final VoidCallback onMicTapped;
  final VoidCallback onSmileyTapped;

  MapMarkerGenerator(
      {required this.currentLocation,
      required this.onCurrentLocationMarkerTapped,
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

  void setup() async {
    await _generateMarkerIcon();
    await _computeMarker();
    _generateCircularMenuIcons();
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
    markerAddDrawableRoot.picture.dispose();
    baseMarkerDrawableRoot.picture.dispose();

    _streamController.close();
  }

  // region private helper
  // to draw marker with animation
  late final PictureInfo baseMarkerDrawableRoot;
  late final PictureInfo markerAddDrawableRoot;

  late final BitmapDescriptor penMarkerBitmap;
  late final BitmapDescriptor emojiMarkerBitmap;
  late final BitmapDescriptor cameraMarkerBitmap;
  late final BitmapDescriptor voiceMarkerBitmap;

  // generate marker base drawable from SVG asset
  Future<PictureInfo> _createDrawableRoot(String svgContent) async {
    // load the base marker svg string from asset
    // load the base marker from svg
    return vg.loadPicture(SvgStringLoader(svgContent), null);
  }

  Future<void> _generateMarkerIcon() async {
    baseMarkerDrawableRoot = await _createDrawableRoot(markerBaseSvg);
    markerAddDrawableRoot = await _createDrawableRoot(markerAdd);
    penMarkerBitmap = await _createDrawableRoot(idCircularIconPencil)
        .then((PictureInfo value) => _computeMenuMarker(value));
    emojiMarkerBitmap = await _createDrawableRoot(idCircularIconEmoji)
        .then((PictureInfo value) => _computeMenuMarker(value));
    cameraMarkerBitmap = await _createDrawableRoot(idCircularIconCamera)
        .then((PictureInfo value) => _computeMenuMarker(value));
    voiceMarkerBitmap = await _createDrawableRoot(idCircularIconMicro)
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
    final double scale = markerSize / baseMarkerDrawableRoot.size.height;
    canvas.scale(scale, scale);
    canvas.drawPicture(baseMarkerDrawableRoot.picture);
    canvas.restore();

    // draw marker add
    // translate to desired location on canvas
    final double markerAddSize = baseMarkerDrawableRoot.size.width *
        scale *
        3 /
        4; // 3 quarter of base marker
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

      canvas.scale(markerAddSize / markerAddDrawableRoot.size.width,
          markerAddSize / markerAddDrawableRoot.size.height);
      canvas.drawPicture(markerAddDrawableRoot.picture);

      // unlock canvas
      canvas.restore();
    } else {
      // do normal drawing
      canvas.save();
      canvas.scale(markerAddSize / markerAddDrawableRoot.size.width,
          markerAddSize / markerAddDrawableRoot.size.height);
      canvas.drawPicture(markerAddDrawableRoot.picture);
      canvas.restore();
    }

    final ByteData? pngBytes = await (await recorder
            .endRecording()
            .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      if (!_streamController.isClosed) {
        _markers.add(Marker(
            markerId: const MarkerId(baseMarkerCurrentLocationId),
            position:
                LatLng(currentLocation.latitude, currentLocation.longitude),
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
            position:
                LatLng(currentLocation.latitude, currentLocation.longitude),
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
            position: currentLocation,
            icon: cameraMarkerBitmap,
            anchor: cameraMenuPosition,
            onTap: onCameraTapped),
        Marker(
            markerId: const MarkerId(menuPencilMarkerLocationId),
            position: currentLocation,
            icon: penMarkerBitmap,
            anchor: penMenuPosition,
            onTap: onPenTapped),
        Marker(
            markerId: const MarkerId(menuEmojiMarkerLocationId),
            position: currentLocation,
            icon: emojiMarkerBitmap,
            anchor: smileyMenuPosition,
            onTap: onSmileyTapped),
        Marker(
            markerId: const MarkerId(menuVoiceMarkerLocationId),
            position: currentLocation,
            icon: voiceMarkerBitmap,
            anchor: micMenuPosition,
            onTap: onMicTapped),
      });
    }
    _streamController.sink.add(_markers);
  }
  // endregion
}
