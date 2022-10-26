import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/gen/assets.gen.dart';

class GoogleMapView extends StatefulWidget {
  final LatLng currentLocation;

  const GoogleMapView({required this.currentLocation, Key? key})
      : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  static final StreamController<Uint8List> _streamController =
      StreamController<Uint8List>();
  Stream<Uint8List> markerData = _streamController.stream;

  // to draw marker with animation
  late final DrawableRoot baseMarkerDrawableRoot;
  late final DrawableRoot markerAddDrawableRoot;

  @override
  void initState() {
    super.initState();

    // generate marker icon
    _generateMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
      stream: markerData,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        final Uint8List? data = snapshot.data;
        final BitmapDescriptor icon = data == null
            ? BitmapDescriptor.defaultMarker
            : BitmapDescriptor.fromBytes(data);

        return GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.currentLocation.latitude,
                    widget.currentLocation.longitude),
                zoom: 15),
            markers: <Marker>{
              Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: widget.currentLocation,
                  icon: icon)
            });
      },
    );
  }

  Future<void> _generateMarkerIcon() async {
    baseMarkerDrawableRoot = await _createBaseMarkerDrawableRoot();
    markerAddDrawableRoot = await _createCenterMarkerDrawableRoot();

    return _computeMarker();
  }

  // generate marker base drawable from SVG asset
  Future<DrawableRoot> _createBaseMarkerDrawableRoot() async {
    // load the base marker svg string from asset
    final String baseMarkerSvgString =
        await rootBundle.loadString(Assets.images.markerBase);
    // load the base marker from svg
    return svg.fromSvgString(baseMarkerSvgString, Assets.images.markerBase);
  }

  // generate center marker from SVG asset
  Future<DrawableRoot> _createCenterMarkerDrawableRoot() async {
    // load add/close icon from svg string
    final String markerCenterSvgString =
        await rootBundle.loadString(Assets.images.markerAdd);
    // load marker add into drawable root from svg
    return svg.fromSvgString(markerCenterSvgString, Assets.images.markerAdd);
  }

  // draw complete marker with angle
  void _computeMarker({double angle = 0}) async {
    const double markerSize = 100.0;

    // create canvas to draw
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    // draw baseMarker on canvas
    const double markerAddSize = 24;
    baseMarkerDrawableRoot.scaleCanvasToViewBox(
        canvas, const Size(markerSize, markerSize));
    baseMarkerDrawableRoot.clipCanvasToViewBox(canvas);
    baseMarkerDrawableRoot.draw(
        canvas,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    // draw marker add
    // translate to desired location on canvas
    canvas.translate(4, 4);
    if (angle % 90 != 0) {
      // lock canvas - prepare to draw marker add with desired rotation
      // only do this if angle is not a power of 90
      canvas.save();
      final double r =
          sqrt(markerAddSize * markerAddSize + markerAddSize * markerAddSize) / 2;
      final double alpha = atan(markerAddSize / markerAddSize);
      final double beta = alpha + angle;
      final double shiftY = r * sin(beta);
      final double shiftX = r * cos(beta);
      final double translateX = markerAddSize / 2 - shiftX;
      final double translateY = markerAddSize / 2 - shiftY;
      canvas.translate(translateX, translateY);
      canvas.rotate(angle);

      markerAddDrawableRoot.scaleCanvasToViewBox(
          canvas, const Size(markerAddSize, markerAddSize));
      markerAddDrawableRoot.clipCanvasToViewBox(canvas);
      markerAddDrawableRoot.draw(
          canvas,
          Rect.fromPoints(
              const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));
      // unlock canvas
      canvas.restore();
    } else {
      // do normal drawing
      markerAddDrawableRoot.scaleCanvasToViewBox(
          canvas, const Size(markerAddSize, markerAddSize));
      markerAddDrawableRoot.clipCanvasToViewBox(canvas);
      markerAddDrawableRoot.draw(
          canvas,
          Rect.fromPoints(
              const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));
    }

    final ByteData? pngBytes = await (await recorder
            .endRecording()
            .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      _streamController.sink.add(Uint8List.view(pngBytes.buffer));
    }
  }
}
