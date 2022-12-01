import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/constants/dimens.dart';
import 'package:interactive_diary/constants/map_style.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set<Marker>>(
        stream: markerData,
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
              onCameraMove: (_) => _closeMenuIfOpening(),
              onTap: (_) => _closeMenuIfOpening(),
              onLongPress: (_) => _closeMenuIfOpening(),
              markers: data.data ?? <Marker>{},
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false),
        ));
  }

  void _openContentList(BuildContext context) {
    const screenEdgeSpacing = 16.0;
    context.showIDBottomSheetCustom(
        dialog: DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.7,
          builder: (_, ScrollController controller) {
            return Container(
              // color: Colors.red,
              width: double.infinity,
              color: Colors.white,
              child: ListView(
                controller: controller,
                  children: [
                    const Gap.v12(),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.circular(4.0)
                      ),
                    ),
                    const Gap.v12(),
                    SafeArea(
                      bottom: true,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenEdgeSpacing, right: screenEdgeSpacing, bottom: MediaQuery.of(context).viewPadding.bottom),
                        child: LocationAddressBoxView(
                          address: 'Shop 11, The Strand Arcade, 412-414 George St, Sydney NSW 2000, Australia',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: screenEdgeSpacing, right: screenEdgeSpacing),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, idx) => const ContentItemView(screenEdgeSpacing: screenEdgeSpacing,),
                          separatorBuilder: (_, idx) => const Gap.v12(),
                          itemCount: 5
                      ),
                    )
                  ],
                ),
            );
          }
        )
    );
  }

  void _closeMenuIfOpening() {
    if (_controller.value == 1) {
      _controller.reverse();
    }
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
              } else {
                _openContentList(context);
                _controller.forward();
              }
            }));
      }
    }
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

class ContentItemView extends StatelessWidget {
  final double screenEdgeSpacing;
  const ContentItemView({required this.screenEdgeSpacing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris';
    final List<String> images = [
      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    ];
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Image.network('https://ps.w.org/user-avatar-reloaded/assets/icon-128x128.png?rev=2540745'),
              ),
              const Gap.h12(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hoang Nguyen', style: Theme.of(context).textTheme.titleSmall,),
                  const Gap.v04(),
                  Row(
                    children: [
                      Text('Sep 3, 2022 at 10:12 PM', style: Theme.of(context).textTheme.bodySmall,),
                      const Gap.h04(),
                      const _DotView(),
                      const Gap.h04(),
                      // Icon(Icons.supervised_user_circle_sharp, color: NartusColor.grey,),
                      SvgPicture.asset(
                        Assets.images.idProfileUserIconPadding, color: NartusColor.grey,
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              // Icon(Icons.menu, color: NartusColor.grey,)
              SvgPicture.asset(Assets.images.idMoreIcon)
            ],
          ),
          const Gap.v08(),
          if (text.isNotEmpty)...[
            _textAndImageView(text, images, context, screenEdgeSpacing)
          ] else if (images.isNotEmpty)...[

          ],
          const Gap.v16(),
          Row(
            children: [
              // Icon(Icons.heart_broken),
              SvgPicture.asset(Assets.images.idHeartIconPadding),
              const Gap.h16(),
              // Icon(Icons.heart_broken),
              SvgPicture.asset(Assets.images.idMessageIconPadding),
              const Gap.h16(),
              // Icon(Icons.heart_broken),
              SvgPicture.asset(Assets.images.idShareIconPadding),
              Spacer(),
              Text('5 likes', style: Theme.of(context).textTheme.bodySmall,),
              const Gap.h04(),
              const _DotView(),
              const Gap.h04(),
              Text('4 comments', style: Theme.of(context).textTheme.bodySmall,),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _textAndImageView(String text, List<String> images, BuildContext context, double screenEdgeSpacing) {
    const int itemsEachRow = 3;
    const double imageSpacing = 4;
    final Size size = MediaQuery.of(context).size;
    final double imageWidth = (size.width - (2 * screenEdgeSpacing) - ((itemsEachRow - 1) * imageSpacing)) / itemsEachRow;
    final bool isHaveMoreImagesThanItemsEachRow = images.length > itemsEachRow;
    final List<String> displayImages = isHaveMoreImagesThanItemsEachRow ? images.take(itemsEachRow).toList() : images;
    return Column(
      children: [
        Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),),
        if (images.isNotEmpty)...[
          const Gap.v12(),
          Row(
            children: [
              ...displayImages.asMap().entries.map((e) {
                print('INDEX : ${e.key} | ${e.value}');
                // print('INDEX EQUAL : ${images.indexOf(e) == (itemsEachRow - 1)}');
                // print('HAVE MORE IMAGES : ${isHaveMoreImagesThanItemsEachRow}');
                // print('TOTAL : ${images.indexOf(e) == (itemsEachRow - 1) && isHaveMoreImagesThanItemsEachRow}');
                print('================================');
                return Container(
                  padding: e.key == (itemsEachRow - 1)
                      ? EdgeInsets.zero : const EdgeInsets.only(right: imageSpacing),
                  width: imageWidth,
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e.value),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            if (e.key == (itemsEachRow - 1) && isHaveMoreImagesThanItemsEachRow)...[
                              Positioned(
                                  top: 0, bottom: 0, left: 0, right: 0,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.grey.shade300.withOpacity(0.5),
                                    alignment: Alignment.center,
                                    child: Text('+ ${images.length - itemsEachRow}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: NartusColor.white),),
                                  )
                              )
                            ]
                          ],
                        ),
                      )
                  ),
                );
              }),
              // ...displayImages.map((e) => Stack(
              //   children: [
              //     Container(
              //       padding: images.indexOf(e) == (itemsEachRow - 1)
              //           ? EdgeInsets.zero : const EdgeInsets.only(right: imageSpacing),
              //       width: imageWidth,
              //       child: AspectRatio(
              //         aspectRatio: 1,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: NetworkImage(e),
              //               fit: BoxFit.contain
              //             )
              //           ),
              //         ),
              //       ),
              //     ),
              //     // AspectRatio(
              //     //   aspectRatio: 1,
              //     //   child: ,
              //     // ),
              //     if (images.indexOf(e) == (itemsEachRow - 1) && isHaveMoreImagesThanItemsEachRow)...[
              //       Container(
              //         color: Colors.grey.shade300,
              //         child: Text('+ ${images.length - itemsEachRow}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: NartusColor.white),),
              //       )
              //     ]
              //   ],)
              // )
            ],
          )
        ]
      ],
    );
  }
}

class _DotView extends StatelessWidget {
  const _DotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3, width: 3,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NartusColor.grey,
      ),
    );
  }
}


class LocationAddressBoxView extends StatelessWidget {
  final String address;
  const LocationAddressBoxView({required this.address, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: NartusColor.gradient,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15, width: 15,
            child: SvgPicture.asset(Assets.images.markerBase, semanticsLabel: 'Current location address : $address',),
          ),
          const Gap.h08(),
          Expanded(
            child: Text(address, style: Theme.of(context).textTheme.bodySmall,)
          )
        ],
      ),
    );
  }
}
