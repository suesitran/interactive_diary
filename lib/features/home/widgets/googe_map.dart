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

class _GoogleMapViewState extends State<GoogleMapView>
    with TickerProviderStateMixin {
  static final StreamController<Uint8List> _streamController =
      StreamController<Uint8List>.broadcast();

  static final StreamController<Uint8List> _menuCameraCtrl =
    StreamController<Uint8List>.broadcast();
  Stream<Uint8List> menuCameraData = _menuCameraCtrl.stream;

  static final StreamController<Uint8List> _menuVoiceCtrl =
    StreamController<Uint8List>.broadcast();
  Stream<Uint8List> menuVoiceData = _menuVoiceCtrl.stream;

  static final StreamController<Uint8List> _menuEmojiCtrl =
    StreamController<Uint8List>.broadcast();
  Stream<Uint8List> menuEmojiData = _menuEmojiCtrl.stream;

  static final StreamController<Uint8List> _menuPenCtrl =
    StreamController<Uint8List>.broadcast();
  Stream<Uint8List> menuPenData = _menuPenCtrl.stream;

  Stream<Uint8List> markerData = _streamController.stream;

  // to draw marker with animation
  late final DrawableRoot baseMarkerDrawableRoot;
  late final DrawableRoot markerAddDrawableRoot;

  late final AnimationController _controller;

  late Animation<Offset> popupPenAnimation, popupEmojiAnimation,
      popupCameraAnimation, popupVoiceAnimation;

  late bool isShowingMenu;

  @override
  void initState() {
    super.initState();

    isShowingMenu = false;

    _generateCircularMenuIcons();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        _computeMarker(angleInDegree: _controller.value * 45);

        /// Open & close menu
        if (_controller.value > 0) {
          setState(() {
            isShowingMenu = true;
          });
        } else {
          setState(() {
            isShowingMenu = false;
          });
        }
      });

    // Specify circular menu icon's animation
    popupPenAnimation = _declareMenuIconsAnimation(start: const Offset(0.5, 1.0), end: const Offset(3, 3), controler: _controller);
    popupEmojiAnimation = _declareMenuIconsAnimation(start: const Offset(0.5, 1.0), end: const Offset(0, 3), controler: _controller);
    popupCameraAnimation = _declareMenuIconsAnimation(start: const Offset(0.5, 1.0), end: const Offset(-1, 3), controler: _controller);
    popupVoiceAnimation = _declareMenuIconsAnimation(start: const Offset(0.5, 1.0), end: const Offset(-2, 3), controler: _controller);

    // generate marker icon
    _generateMarkerIcon();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uint8List>(
      stream: menuPenData,
      builder: (_, AsyncSnapshot<Uint8List> penData) => StreamBuilder<Uint8List>(
        stream: menuVoiceData,
        builder: (_, AsyncSnapshot<Uint8List> voiceData) => StreamBuilder<Uint8List>(
          stream: menuEmojiData,
          builder: (_, AsyncSnapshot<Uint8List> emojiData) => StreamBuilder<Uint8List>(
              stream: menuCameraData,
              builder: (_, AsyncSnapshot<Uint8List> menuCamera) => StreamBuilder<Uint8List>(
                stream: markerData,
                builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                  final Uint8List? data = snapshot.data;
                  final BitmapDescriptor icon = data == null
                      ? BitmapDescriptor.defaultMarker
                      : BitmapDescriptor.fromBytes(data);

                  return AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) => GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(widget.currentLocation.latitude,
                                  widget.currentLocation.longitude),
                              zoom: 15),
                          markers: <Marker>{
                            Marker(
                                markerId: const MarkerId('currentLocation'),
                                position: widget.currentLocation,
                                icon: icon,
                                onTap: () {
                                  if (_controller.value == 1) {
                                    _controller.reverse();
                                  } else {
                                    _controller.forward();
                                  }
                                }),
                            if (isShowingMenu)...[
                              Marker(
                                  markerId: const MarkerId('menuCameraMarkerLocation'),
                                  position: widget.currentLocation,
                                  icon: (() {
                                    if (menuCamera.data != null) {
                                      return BitmapDescriptor.fromBytes(
                                        Uint8List.view(menuCamera.data!.buffer));
                                    }
                                    return BitmapDescriptor.defaultMarker;
                                  } ()),
                                  anchor: popupCameraAnimation.value,
                                  onTap: () {
                                    print('ABC');
                                  }
                              ),
                              Marker(
                                  markerId: const MarkerId('menuPencilMarkerLocation'),
                                  position: widget.currentLocation,
                                  icon: (() {
                                    if (penData.data != null) {
                                      return BitmapDescriptor.fromBytes(
                                        Uint8List.view(penData.data!.buffer));
                                    }
                                    return BitmapDescriptor.defaultMarker;
                                  } ()),
                                  anchor: popupPenAnimation.value,
                                  onTap: () {
                                    print('PEN');
                                  }
                              ),
                              Marker(
                                  markerId: const MarkerId('menuEmojiMarkerLocation'),
                                  position: widget.currentLocation,
                                  icon: (() {
                                    if (emojiData.data != null) {
                                      return BitmapDescriptor.fromBytes(
                                        Uint8List.view(emojiData.data!.buffer));
                                    }
                                    return BitmapDescriptor.defaultMarker;
                                  } ()),
                                  anchor: popupEmojiAnimation.value,
                                  onTap: () {
                                    print('PEN');
                                  }
                              ),
                              Marker(
                                  markerId: const MarkerId('menuVoiceMarkerLocation'),
                                  position: widget.currentLocation,
                                  icon: (() {
                                    if (voiceData.data != null) {
                                      return BitmapDescriptor.fromBytes(
                                        Uint8List.view(voiceData.data!.buffer));
                                    }
                                    return BitmapDescriptor.defaultMarker;
                                  } ()),
                                  anchor: popupVoiceAnimation.value,
                                  onTap: () {
                                    print('PEN');
                                  }
                              ),
                            ]
                          }
                      )
                  );
                },
                initialData: Uint8List(0),
              )
          )
        )
      )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamController.close();
    super.dispose();
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
  void _computeMarker({double angleInDegree = 0}) async {
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
              const Offset(0.0, 0.0), const Offset(markerSize, markerSize)));

      // unlock canvas
      canvas.restore();

      // await _drawCircularMenuIcons(canvas, recorder);
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
      if (!_streamController.isClosed) {
        _streamController.sink.add(Uint8List.view(pngBytes.buffer));
      }
    }
  }

  // Future<void> _drawCircularMenuIcons() async {
  //   const double menuIconSize = 100.0;
  //   final String menuCamera =
  //       await rootBundle.loadString(Assets.images.idCameraIcon);
  //
  //   final PictureRecorder recorder = PictureRecorder();
  //   final Canvas canvas = Canvas(
  //       recorder,
  //       Rect.fromPoints(
  //           const Offset(0.0, 0.0), const Offset(menuIconSize, menuIconSize)));
  //
  //   final DrawableRoot menuCameraDrawable = await svg.fromSvgString(menuCamera, Assets.images.idCameraIcon, theme: SvgTheme(currentColor: Colors.red));
  //
  //   menuCameraDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
  //   menuCameraDrawable.clipCanvasToViewBox(canvas);
  //   menuCameraDrawable.draw(
  //       canvas,
  //       Rect.fromPoints(
  //           const Offset(0.0, 0.0), const Offset(40, 40)));
  //
  //   final ByteData? pngBytes = await (await recorder
  //       .endRecording()
  //       .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
  //       .toByteData(format: ImageByteFormat.png);
  //
  //   if (pngBytes != null) {
  //     if (!_menuCameraCtrl.isClosed) {
  //       _menuCameraCtrl.sink.add(Uint8List.view(pngBytes.buffer));
  //     }
  //   }
  // }

  void _generateCircularMenuIcons() async {
    const double menuIconSize = 100.0;
    final List<MapEntry<String, String>> menuIcons = <MapEntry<String, String>>[
      MapEntry<String, String>(Assets.images.idCameraIcon, await rootBundle.loadString(Assets.images.idCameraIcon)),
      MapEntry<String, String>(Assets.images.idMicroIcon, await rootBundle.loadString(Assets.images.idMicroIcon)),
      MapEntry<String, String>(Assets.images.idSmileIcon, await rootBundle.loadString(Assets.images.idSmileIcon)),
      MapEntry<String, String>(Assets.images.idPencilIcon, await rootBundle.loadString(Assets.images.idPencilIcon)),
    ];

    final List<ByteData?> iconsPngByte = [];
    for (MapEntry<String, String> icon in menuIcons) {
      final PictureRecorder recorder = PictureRecorder();
      final Canvas canvas = Canvas(
          recorder,
          Rect.fromPoints(
              const Offset(0.0, 0.0), const Offset(menuIconSize, menuIconSize)));

      final DrawableRoot iconDrawable = await svg.fromSvgString(icon.value, icon.key);

      iconDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
      iconDrawable.clipCanvasToViewBox(canvas);
      iconDrawable.draw(
          canvas,
          Rect.fromPoints(
              const Offset(0.0, 0.0), const Offset(80, 80)));

      final ByteData? pngBytes = await (await recorder
          .endRecording()
          .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
          .toByteData(format: ImageByteFormat.png);
      iconsPngByte.add(pngBytes);
    }

    if (iconsPngByte[0] != null) {
      if (!_menuCameraCtrl.isClosed) {
        _menuCameraCtrl.sink.add(Uint8List.view(iconsPngByte[0]!.buffer));
      }
    }

    if (iconsPngByte[1] != null) {
      if (!_menuVoiceCtrl.isClosed) {
        _menuVoiceCtrl.sink.add(Uint8List.view(iconsPngByte[1]!.buffer));
      }
    }

    if (iconsPngByte[2] != null) {
      if (!_menuEmojiCtrl.isClosed) {
        _menuEmojiCtrl.sink.add(Uint8List.view(iconsPngByte[2]!.buffer));
      }
    }

    if (iconsPngByte[3] != null) {
      if (!_menuPenCtrl.isClosed) {
        _menuPenCtrl.sink.add(Uint8List.view(iconsPngByte[3]!.buffer));
      }
    }

  }

  // void _generateCircularMenuIcons() async {
  //   const double menuIconSize = 100.0;
  //   final String menuCamera = await rootBundle.loadString(Assets.images.idCameraIcon);
  //   final String menuVoice = await rootBundle.loadString(Assets.images.idMicroIcon);
  //   final String menuEmoji = await rootBundle.loadString(Assets.images.idSmileIcon);
  //   final String menuPencil = await rootBundle.loadString(Assets.images.idPencilIcon);
  //
  //   final DrawableRoot menuCameraDrawable = await svg.fromSvgString(menuCamera, Assets.images.idCameraIcon);
  //   final DrawableRoot menuEmojiDrawable = await svg.fromSvgString(menuEmoji, Assets.images.idSmileIcon);
  //   final DrawableRoot menuVoiceDrawable = await svg.fromSvgString(menuVoice, Assets.images.idMicroIcon);
  //   final DrawableRoot menuPencilDrawable = await svg.fromSvgString(menuPencil, Assets.images.idPencilIcon);
  //
  //   final PictureRecorder recorder = PictureRecorder();
  //   final Canvas canvas = Canvas(recorder, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(menuIconSize, menuIconSize)));
  //
  //   menuCameraDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
  //   menuCameraDrawable.clipCanvasToViewBox(canvas);
  //   menuCameraDrawable.draw(canvas, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(40, 40)));
  //
  //   // final ByteData? cameraPngBytes = await (await recorder
  //   //   .endRecording()
  //   //   .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
  //   //   .toByteData(format: ImageByteFormat.png);
  //   //
  //   // if (cameraPngBytes != null) {
  //   //   if (!_menuCameraCtrl.isClosed) {
  //   //     _menuCameraCtrl.sink.add(Uint8List.view(cameraPngBytes.buffer));
  //   //   }
  //   // }
  //
  //   // try {
  //     menuEmojiDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
  //     menuEmojiDrawable.clipCanvasToViewBox(canvas);
  //     menuEmojiDrawable.draw(canvas, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(40, 40)));
  //   //
  //   //   final ByteData? emojiPngBytes = await (await recorder
  //   //       .endRecording()
  //   //       .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
  //   //       .toByteData(format: ImageByteFormat.png);
  //   //
  //   //   if (emojiPngBytes != null) {
  //   //     if (!_menuEmojiCtrl.isClosed) {
  //   //       _menuEmojiCtrl.sink.add(Uint8List.view(emojiPngBytes.buffer));
  //   //     }
  //   //   }
  //   // } catch (e, trace) {
  //   //   print('ERR : ${e.toString()}');
  //   //   print('TRACE : ${trace.toString()}');
  //   // }
  //
  //   menuVoiceDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
  //   menuVoiceDrawable.clipCanvasToViewBox(canvas);
  //   menuVoiceDrawable.draw(canvas, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(40, 40)));
  //
  //   // final ByteData? voicePngBytes = await (await recorder
  //   //     .endRecording()
  //   //     .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
  //   //     .toByteData(format: ImageByteFormat.png);
  //   //
  //   // if (voicePngBytes != null) {
  //   //   if (!_menuVoiceCtrl.isClosed) {
  //   //     _menuVoiceCtrl.sink.add(Uint8List.view(voicePngBytes.buffer));
  //   //   }
  //   // }
  //
  //   menuPencilDrawable.scaleCanvasToViewBox(canvas, const Size(menuIconSize, menuIconSize));
  //   menuPencilDrawable.clipCanvasToViewBox(canvas);
  //   menuPencilDrawable.draw(canvas, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(40, 40)));
  //
  //   final ByteData? pencilPngBytes = await (await recorder
  //       .endRecording()
  //       .toImage(menuIconSize.toInt(), menuIconSize.toInt()))
  //       .toByteData(format: ImageByteFormat.png);
  //
  //   if (pencilPngBytes != null) {
  //     if (!_menuPenCtrl.isClosed) {
  //       _menuPenCtrl.sink.add(Uint8List.view(pencilPngBytes.buffer));
  //     }
  //   }
  // }


  Animation<Offset> _declareMenuIconsAnimation({required Offset start, required Offset end, required AnimationController controler}) {
    return Tween<Offset>(begin: start, end: end).animate(CurvedAnimation(
        parent: controler, curve: Curves.bounceOut));
  }

}