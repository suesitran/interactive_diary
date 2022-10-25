import 'dart:async';
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
      initialData: Uint8List(0),
    );
  }

  Future<void> _generateMarkerIcon() async {
    const double markerSize = 200.0;
    // load the base marker svg string from asset
    final String baseMarkerSvgString =
        await rootBundle.loadString(Assets.images.markerBase);
    // load the base marker from svg
    baseMarkerDrawableRoot =
        await svg.fromSvgString(baseMarkerSvgString, Assets.images.markerBase);

    // load add/close icon from svg string
    final String markerCenterSvgString =
        await rootBundle.loadString(Assets.images.markerAdd);
    // load marker add into drawable root from svg
    markerAddDrawableRoot =
        await svg.fromSvgString(markerCenterSvgString, Assets.images.markerAdd);

    // create canvas to draw
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));
    // canvas.drawRect(Rect.fromPoints(const Offset(0.0, 0.0), const Offset(markerSize, markerSize)), Paint()..color = Colors.green);

    // draw baseMarker on canvas
    baseMarkerDrawableRoot.scaleCanvasToViewBox(
        canvas, const Size(markerSize, markerSize));
    baseMarkerDrawableRoot.clipCanvasToViewBox(canvas);
    baseMarkerDrawableRoot.draw(
        canvas,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    // draw marker add
    canvas.translate(20, 16);
    markerAddDrawableRoot.scaleCanvasToViewBox(canvas, const Size(24, 24));
    markerAddDrawableRoot.clipCanvasToViewBox(canvas);
    markerAddDrawableRoot.draw(
        canvas,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    final ByteData? pngBytes = await (await recorder
            .endRecording()
            .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      _streamController.sink.add(Uint8List.view(pngBytes.buffer));
    }
  }
}
