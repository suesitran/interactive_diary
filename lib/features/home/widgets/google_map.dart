import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/map_style.dart';
import 'package:interactive_diary/features/home/widgets/controller/map_animation_controller.dart';
import 'package:interactive_diary/features/home/widgets/markers/map_markers_generator.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:interactive_diary/bloc/camera_permission/camera_permission_bloc.dart';

class GoogleMapView extends StatefulWidget {
  final LatLng currentLocation;
  final String? address;
  final String? business;

  final VoidCallback onMenuOpened;
  final VoidCallback onMenuClosed;

  const GoogleMapView(
      {required this.currentLocation,
      required this.address,
      required this.business,
      required this.onMenuOpened,
      required this.onMenuClosed,
      Key? key})
      : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView>
    with TickerProviderStateMixin {
  late final MapAnimationController _controller;
  GoogleMapController? mapController;

  late Animation<Offset> popupPenAnimation;
  late Animation<Offset> popupEmojiAnimation;
  late Animation<Offset> popupCameraAnimation;
  late Animation<Offset> popupVoiceAnimation;

  late Animation<double> currentLocationAnimation;

  late final MapMarkerGenerator mapMarkerGenerator;

  @override
  void initState() {
    super.initState();

    mapMarkerGenerator = MapMarkerGenerator(
        currentLocation: widget.currentLocation,
        onCurrentLocationMarkerTapped: () {
          if (_controller.value == 1) {
            _controller.reverse();
            // _closeContentsBottomSheet();
          } else {
            _controller.forward();
            // _openContentsBottomSheet();
          }
        },
        onCameraTapped: () {
          context
              .read<CameraPermissionBloc>()
              .add(ValidateCameraPermissionEvent());
          _closeMenuIfOpening();
        },
        onPenTapped: () {
          context.gotoWriteDiaryScreen(
              widget.currentLocation, widget.address, widget.business);
          _closeMenuIfOpening();
        },
        onSmileyTapped: () {
          _closeMenuIfOpening();
        },
        onMicTapped: () {
          _closeMenuIfOpening();
        });
    mapMarkerGenerator.setup();

    _initResources();
  }

  void _initResources() {
    _controller = MapAnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      onAnimationForward: widget.onMenuOpened,
      onAnimationBackward: widget.onMenuClosed,
      onUpdate: (value) {
        mapMarkerGenerator.onAnimation(
            animValue: value,
            cameraMenuPosition: popupCameraAnimation.value,
            micMenuPosition: popupVoiceAnimation.value,
            penMenuPosition: popupPenAnimation.value,
            smileyMenuPosition: popupEmojiAnimation.value,
            showMenu: _controller.status != AnimationStatus.dismissed);
      },
    );

    _specifyCircularMenuIconsAnimation(_controller);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController?.setMapStyle(MapStyle.paper.value);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set<Marker>>(
        stream: mapMarkerGenerator.markerData,
        builder: (_, AsyncSnapshot<Set<Marker>> data) => AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) => GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.currentLocation.latitude,
                        widget.currentLocation.longitude),
                    zoom: 15),
                onMapCreated: (GoogleMapController controller) =>
                    _onMapCreated(controller),
                onCameraMoveStarted: () => _closeMenuIfOpening(),
                onTap: (_) => _closeMenuIfOpening(),
                onLongPress: (_) => _closeMenuIfOpening(),
                markers: data.data ?? <Marker>{},
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                myLocationButtonEnabled: false)));
  }

  void _closeMenuIfOpening() {
    if (_controller.value == 1) {
      _controller.reverse();
    }

    // _closeContentsBottomSheet();
  }

  @override
  void dispose() {
    mapMarkerGenerator.dispose();

    _controller.dispose();
    mapController?.dispose();
    super.dispose();
  }

  void _specifyCircularMenuIconsAnimation(AnimationController controller) {
    /// Offset(0.5, 1.0) : Is default anchor of Marker
    const Offset baseAnchor = Offset(0.5, 1.0);

    const double diameter = 1.0;
    const double penDegree = 15.0;
    const double cameraDegree = 65.0;
    const double voiceDegree = 115.0;
    const double emojiDegree = 165.0;

    const double baseX = 0.5;
    const double baseY = 0.5;

    final double xPen = cos(penDegree * pi / 180) * diameter + baseX;
    final double yPen = sin(penDegree * pi / 180) * diameter + baseY;

    final double xEmoji = cos(emojiDegree * pi / 180) * diameter + baseX;
    final double yEmoji = sin(emojiDegree * pi / 180) * diameter + baseY;

    final double xCamera = cos(cameraDegree * pi / 180) * diameter + baseX;
    final double yCamera = sin(cameraDegree * pi / 180) * diameter + baseY;

    final double xVoice = cos(voiceDegree * pi / 180) * diameter + baseX;
    final double yVoice = sin(voiceDegree * pi / 180) * diameter + baseY;

    popupPenAnimation = _declareMenuIconsAnimation(
        start: baseAnchor, end: Offset(xPen, yPen), controller: controller);
    popupEmojiAnimation = _declareMenuIconsAnimation(
        start: baseAnchor, end: Offset(xEmoji, yEmoji), controller: controller);
    popupCameraAnimation = _declareMenuIconsAnimation(
        start: baseAnchor,
        end: Offset(xCamera, yCamera),
        controller: controller);
    popupVoiceAnimation = _declareMenuIconsAnimation(
        start: baseAnchor, end: Offset(xVoice, yVoice), controller: controller);

    currentLocationAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }

  Animation<Offset> _declareMenuIconsAnimation(
      {required Offset start,
      required Offset end,
      required AnimationController controller}) {
    return Tween<Offset>(begin: start, end: end)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }
}
