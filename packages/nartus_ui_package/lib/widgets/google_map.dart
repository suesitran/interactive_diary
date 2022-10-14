import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class GoogleMapWidget extends StatefulWidget {
  final double _latitude;
  final double _longitude;
  final bool? _isAnimation;
  final void Function()? _onTap;

  const GoogleMapWidget({
    Key? key,
    required double latitude,
    required double longitude,
    bool isAnimation = false,
    required void Function() onTap,
  })  : _latitude = latitude,
        _longitude = longitude,
        _isAnimation = isAnimation,
        _onTap = onTap,
        super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

@override
class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late Future<List<Marker>> futureListMarker;
  late Future<Marker> futureMarker;
  late Marker marker;

  Future<List<Marker>> generateListMarkers() async {
    List<Marker> markers = [];
    final icon = widget._isAnimation == true
        ? await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(24, 24)),
            'assets/images/marker_ontap.png')
        : await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(24, 24)),
            'assets/images/marker_nonetap.png');

    final marker = Marker(
        markerId: MarkerId(widget._latitude.toString()),
        position: LatLng(widget._latitude, widget._longitude),
        icon: icon,
        onTap: widget._onTap);
    markers.add(marker);
    return markers;
  }

  Widget build(BuildContext context) {
    futureListMarker = generateListMarkers();

    return Stack(
      children: [
        FutureBuilder<List<Marker>>(
            future: futureListMarker,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget._latitude, widget._longitude),
                        zoom: 15),
                    markers: Set<Marker>.of(snapshot.data as Iterable<Marker>));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ],
    );
  }
}
