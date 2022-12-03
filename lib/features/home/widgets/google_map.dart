import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/get_contents/get_contents_bloc.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:interactive_diary/constants/map_style.dart';
import 'package:interactive_diary/features/home/widgets/contents_bottom_sheet_view.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import '../../../main.dart';
import 'content_card_view.dart';
import 'dot_view.dart';
import 'location_address_box_view.dart';

const String menuCameraMarkerLocationId = 'menuCameraMarkerLocationId';
const String menuPencilMarkerLocationId = 'menuPencilMarkerLocationId';
const String menuEmojiMarkerLocationId = 'menuEmojiMarkerLocationId';
const String menuVoiceMarkerLocationId = 'menuVoiceMarkerLocationId';
const String baseMarkerCurrentLocationId = 'currentLocationId';

class GoogleMapView extends StatefulWidget {
  final LatLng currentLocation;

  const GoogleMapView({required this.currentLocation, Key? key})
      : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView>
    with TickerProviderStateMixin {
  static final StreamController<Set<Marker>> _streamController =
  StreamController<Set<Marker>>.broadcast();

  Stream<Set<Marker>> markerData = _streamController.stream;

  // to draw marker with animation
  late final DrawableRoot baseMarkerDrawableRoot;
  late final DrawableRoot markerAddDrawableRoot;

  late final AnimationController _controller;
  late GoogleMapController mapController;

  late Animation<Offset> popupPenAnimation;
  late Animation<Offset> popupEmojiAnimation;
  late Animation<Offset> popupCameraAnimation;
  late Animation<Offset> popupVoiceAnimation;

  late Animation<double> currentLocationAnimation;

  late final BitmapDescriptor penMarkerBitmap;
  late final BitmapDescriptor emojiMarkerBitmap;
  late final BitmapDescriptor cameraMarkerBitmap;
  late final BitmapDescriptor voiceMarkerBitmap;

  late final Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          _controller.reset();
        }
      })
      ..addListener(() {
        _computeMarker(angleInDegree: currentLocationAnimation.value * 45)
            .then((_) => _generateCircularMenuIcons());
      });

    _specifyCircularMenuIconsAnimation(_controller);

    // generate marker icon
    _generateMarkerIcon().then((_) => _generateMenuBitmap());
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(MapStyle.paper.value);
  }

  final List<double> snaps = [1, 0.85, 0.5, 0.2];
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<Set<Marker>>(
        stream: markerData,
        builder: (_, AsyncSnapshot<Set<Marker>> data) => AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(widget.currentLocation.latitude,
                          widget.currentLocation.longitude),
                      zoom: 15),
                  onMapCreated: (GoogleMapController controller) =>
                      _onMapCreated(controller),
                  onCameraMoveStarted: () => _onMapTab(),
                  onCameraMove: (_) => _onMapTab(),
                  onTap: (_) => _onMapTab(),
                  onLongPress: (_) => _onMapTab(),
                  markers: data.data ?? <Marker>{},
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  myLocationButtonEnabled: false),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onPanEnd: (details) {
                      if (details.velocity.pixelsPerSecond.dy > -100) {
                        if (currentPos > 0) {
                          setState(() {
                            currentPos = currentPos - 1;
                          });
                        }
                      } else {
                        if (currentPos < snaps.length - 1) {
                          setState(() {
                            currentPos = currentPos + 1;
                          });
                        }
                      }
                    },
                    // child: CustomBottomSheet(height: size.height - (size.height * snaps[currentPos]),)
                    child: AnimatedContainer(
                      height: size.height - (size.height * snaps[currentPos]),
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                      duration: const Duration(milliseconds: 200),
                      child: Align(alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap.v12(),
                              Container(
                                height: 4,
                                width: MediaQuery.of(context).size.width * .2,
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  borderRadius: BorderRadius.circular(4.0)
                                ),
                              ),
                              const Gap.v12(),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 12, right: 12,
                                  // bottom: MediaQuery.of(context).viewPadding.bottom
                                ),
                                child: const LocationAddressBoxView(
                                  address: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
                                ),
                              ),
                              if (currentPos > 1)...[
                                Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 16, right: 16),
                                      child: BlocBuilder<GetContentsBloc, GetContentsState>(
                                        builder: (_, GetContentsState state) {
                                          if (state.isGettingContentsState) {
                                            return Container(
                                              margin: const EdgeInsets.only(top: 12),
                                              child: const LoadingIndicator(),
                                            );
                                          } else if (state.isDataEmptyState) {
                                            return const SizedBox();
                                          } else if (state.isGetContentsFailedState) {
                                            return ErrorView(error: state.getContentsError,);
                                          } else if (state.isGetContentsSucceedState) {
                                            return ListView.separated(
                                                cacheExtent: 200,
                                                shrinkWrap: true,
                                                itemBuilder: (_, int idx) => Column(
                                                  children: [
                                                    ContentCardView(
                                                      screenEdgeSpacing: 16,
                                                      content: state.getContents[idx],
                                                    ),
                                                    if (idx == state.getContents.length - 1)...[
                                                      const Gap.v16()
                                                    ]
                                                  ],
                                                ),
                                                separatorBuilder: (_, int idx) => const Gap.v12(),
                                                itemCount: state.getContents.length
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      ),
                                    )
                                )
                              ]
                            ],
                          )
                      ),
                    ),
                  ),
                ),
                // AnimatedPositioned(
                //     curve: Curves.decelerate,
                //     top: size.height * snaps[currentPos],
                //     duration: const Duration(milliseconds: 300),
                //     child: GestureDetector(
                //       onPanEnd: (details) {
                //         if (details.velocity.pixelsPerSecond.dy > -100) {
                //           if (currentPos > 0) {
                //             setState(() {
                //               currentPos = currentPos - 1;
                //             });
                //           }
                //         } else {
                //           if (currentPos < snaps.length - 1) {
                //             setState(() {
                //               currentPos = currentPos + 1;
                //             });
                //           }
                //         }
                //       },
                //       // child: CustomBottomSheet(height: size.height - (size.height * snaps[currentPos]),)
                //       child: Container(
                //         height: size.height - (size.height * snaps[currentPos]),
                //         width: size.width,
                //         decoration: const BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                //         child: Align(alignment: Alignment.topCenter,
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Gap.v12(),
                //                 Container(
                //                   height: 2,
                //                   width: 20,
                //                   decoration: BoxDecoration(
                //                       color: Colors.grey[500],
                //                       borderRadius: BorderRadius.circular(4.0)
                //                   ),
                //                 ),
                //                 const Gap.v12(),
                //                 Container(
                //                   margin: EdgeInsets.only(
                //                     left: 12, right: 12,
                //                     // bottom: MediaQuery.of(context).viewPadding.bottom
                //                   ),
                //                   child: LocationAddressBoxView(
                //                     address: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
                //                   ),
                //                 ),
                //                 Flexible(
                //                     child: Container(
                //                       padding: const EdgeInsets.only(left: 16, right: 16),
                //                       child: BlocBuilder<GetContentsBloc, GetContentsState>(
                //                         builder: (_, GetContentsState state) {
                //                           if (state.isGettingContentsState) {
                //                             return Container(
                //                               margin: const EdgeInsets.only(top: 12),
                //                               child: const LoadingIndicator(),
                //                             );
                //                           } else if (state.isDataEmptyState) {
                //                             return const SizedBox();
                //                           } else if (state.isGetContentsFailedState) {
                //                             return ErrorView(error: state.getContentsError,);
                //                           } else if (state.isGetContentsSucceedState) {
                //                             return ListView.separated(
                //                                 cacheExtent: 200,
                //                                 physics: AlwaysScrollableScrollPhysics(),
                //                                 shrinkWrap: true,
                //                                 reverse: true,
                //                                 itemBuilder: (_, int idx) => Column(
                //                                   children: [
                //                                     ContentCardView(
                //                                       screenEdgeSpacing: 16,
                //                                       content: state.getContents[idx],
                //                                     ),
                //                                     if (idx == state.getContents.length - 1)...[
                //                                       const Gap.v16()
                //                                     ]
                //                                   ],
                //                                 ),
                //                                 separatorBuilder: (_, int idx) => const Gap.v12(),
                //                                 itemCount: state.getContents.length
                //                             );
                //                           }
                //                           return const SizedBox();
                //                         },
                //                       ),
                //                     )
                //                 )
                //               ],
                //             )
                //         ),
                //       ),
                //     )
                // ),
              ],
            );
          }
        ));
  }

  void _openContentList(BuildContext context) {
    context.read<GetContentsBloc>().getContents();
    context.showIDBottomSheetCustom(
      dialog: MapBottomSheetView()
    );
  }

  void _onMapTab() {
    if (_controller.value == 1) {
      _controller.reverse();
    }
    _closeContentsBottomSheet();
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamController.close();
    super.dispose();
  }

  Future<void> _generateMarkerIcon() async {
    baseMarkerDrawableRoot =
      await _createDrawableRoot(Assets.images.markerBase);
    markerAddDrawableRoot = await _createDrawableRoot(Assets.images.markerAdd);

    return _computeMarker();
  }

  // generate marker base drawable from SVG asset
  Future<DrawableRoot> _createDrawableRoot(String svgPath) async {
    // load the base marker svg string from asset
    final String baseMarkerSvgString = await rootBundle.loadString(svgPath);
    // load the base marker from svg
    return svg.fromSvgString(baseMarkerSvgString, svgPath);
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
    const double markerAddSize = 24;
    baseMarkerDrawableRoot.scaleCanvasToViewBox(
        canvas, Size(markerSize, markerSize));
    baseMarkerDrawableRoot.clipCanvasToViewBox(canvas);
    baseMarkerDrawableRoot.draw(
        canvas,
        Rect.fromPoints(
            const Offset(0.0, 0.0), Offset(markerSize, markerSize)));

    // draw marker add
    // translate to desired location on canvas
    canvas.translate(4, 4);
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

      markerAddDrawableRoot.scaleCanvasToViewBox(
          canvas, const Size(markerAddSize, markerAddSize));
      markerAddDrawableRoot.clipCanvasToViewBox(canvas);
      markerAddDrawableRoot.draw(
          canvas,
          Rect.fromPoints(
              const Offset(0.0, 0.0), Offset(markerSize, markerSize)));

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
              const Offset(0.0, 0.0), Offset(markerSize, markerSize)));
    }

    final ByteData? pngBytes = await (await recorder
        .endRecording()
        .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      if (!_streamController.isClosed) {
        markers.add(Marker(
          markerId: const MarkerId(baseMarkerCurrentLocationId),
          position: widget.currentLocation,
          icon: BitmapDescriptor.fromBytes(Uint8List.view(pngBytes.buffer)),
          zIndex: 1,
          onTap: () {
            if (_controller.value == 1) {
              _controller.reverse();
              _closeContentsBottomSheet();
            } else {
              _openContentList(context);
              _controller.forward();
              // _openContentsBottomSheet();
            }
          }));
      }
    }
  }

  void _openContentsBottomSheet() {
    context.read<GetContentsBloc>().getContents();
    setState(() {
      if (currentPos == 0) {
        currentPos = 1;
      }
    });
  }

  void _closeContentsBottomSheet() {
    setState(() {
      currentPos = 0;
    });
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
        start: baseAnchor, end: Offset(xCamera, yCamera), controller: controller);
    popupVoiceAnimation = _declareMenuIconsAnimation(
        start: baseAnchor, end: Offset(xVoice, yVoice), controller: controller);

    currentLocationAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }

  void _generateCircularMenuIcons() async {
    markers.removeWhere(
            (Marker element) => element.markerId.value != baseMarkerCurrentLocationId);
    if (_controller.status != AnimationStatus.dismissed) {
      markers.addAll(<Marker>{
        Marker(
          markerId: const MarkerId(menuCameraMarkerLocationId),
          position: widget.currentLocation,
          icon: cameraMarkerBitmap,
          anchor: popupCameraAnimation.value,
          onTap: () {}
        ),
        Marker(
          markerId: const MarkerId(menuPencilMarkerLocationId),
          position: widget.currentLocation,
          icon: penMarkerBitmap,
          anchor: popupPenAnimation.value,
          onTap: () {}
        ),
        Marker(
          markerId: const MarkerId(menuEmojiMarkerLocationId),
          position: widget.currentLocation,
          icon: emojiMarkerBitmap,
          anchor: popupEmojiAnimation.value,
          onTap: () {}
        ),
        Marker(
          markerId: const MarkerId(menuVoiceMarkerLocationId),
          position: widget.currentLocation,
          icon: voiceMarkerBitmap,
          anchor: popupVoiceAnimation.value,
          onTap: () {}
        ),
      });
    }
    _streamController.sink.add(markers);
  }

  Future<void> _generateMenuBitmap() async {
    penMarkerBitmap =
    await _createDrawableRoot(Assets.images.idCircularIconPencil)
        .then((DrawableRoot value) => _computeMenuMarker(value));
    emojiMarkerBitmap =
    await _createDrawableRoot(Assets.images.idCircularIconEmoji)
        .then((DrawableRoot value) => _computeMenuMarker(value));
    cameraMarkerBitmap =
    await _createDrawableRoot(Assets.images.idCircularIconCamera)
        .then((DrawableRoot value) => _computeMenuMarker(value));
    voiceMarkerBitmap =
    await _createDrawableRoot(Assets.images.idCircularIconMicro)
        .then((DrawableRoot value) => _computeMenuMarker(value));

    return _generateCircularMenuIcons();
  }

  Future<BitmapDescriptor> _computeMenuMarker(DrawableRoot drawableRoot) async {
    const double markerSize = 300;

    // create canvas to draw
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(
        recorder,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    // draw baseMarker on canvas
    drawableRoot.scaleCanvasToViewBox(
        canvas, const Size(markerSize, markerSize));
    drawableRoot.clipCanvasToViewBox(canvas);
    drawableRoot.draw(
        canvas,
        Rect.fromPoints(
            const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

    final ByteData? pngBytes = await (await recorder
        .endRecording()
        .toImage(markerSize.toInt(), markerSize.toInt()))
        .toByteData(format: ImageByteFormat.png);

    if (pngBytes != null) {
      return BitmapDescriptor.fromBytes(Uint8List.view(pngBytes.buffer));
    }

    return BitmapDescriptor.defaultMarker;
  }

  Animation<Offset> _declareMenuIconsAnimation(
      {required Offset start,
        required Offset end,
        required AnimationController controller}) {
    return Tween<Offset>(begin: start, end: end)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }
}
//
// class ContentsBottomSheetView extends StatefulWidget {
//   const ContentsBottomSheetView({Key? key}) : super(key: key);
//
//   @override
//   _ContentsBottomSheetViewState createState() => _ContentsBottomSheetViewState();
// }
//
// class _ContentsBottomSheetViewState extends State<ContentsBottomSheetView> {
//
//   final List<double> snapSizes = <double>[0.1, 0.5, 0.8];
//   int currentSnapPos = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     const screenEdgeSpacing = 16.0;
//     final Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * snapSizes[currentSnapPos],
//       child: DraggableScrollableSheet(
//           initialChildSize: 0.1,
//           minChildSize: 0.1,
//           maxChildSize: 0.8,
//           snap: true,
//           snapSizes: snapSizes,
//           builder: (_, ScrollController controller) {
//             return MapBottomSheetView(
//                 screenEdgeSpacing: screenEdgeSpacing, controller: controller);
//           }
//       ),
//     );
//   }
// }

