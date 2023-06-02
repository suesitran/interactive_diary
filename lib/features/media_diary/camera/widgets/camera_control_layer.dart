import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/shutter_button.dart';
import 'package:interactive_diary/features/media_diary/camera/widgets/time_label.dart';
import 'package:intl/intl.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/gaps.dart';

import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/features/media_diary/_shared/widgets/buttons.dart';

class CameraControlsLayer extends StatefulWidget {
  final VoidCallback onGalleryTapped;
  final VoidCallback onShutterTapped;
  final VoidCallback onShutterLongPressStart;
  final VoidCallback onShutterLongPressEnd;

  const CameraControlsLayer(
      {required this.onGalleryTapped,
      required this.onShutterTapped,
      required this.onShutterLongPressStart,
      required this.onShutterLongPressEnd,
      Key? key})
      : super(key: key);

  @override
  State<CameraControlsLayer> createState() => _CameraControlsLayerState();
}

class _CameraControlsLayerState extends State<CameraControlsLayer>
    with TickerProviderStateMixin {
  late final AnimationController _preparationController =
      AnimationController(vsync: this)
        ..duration = const Duration(milliseconds: 100);

  late final Animation<Offset> _slideLeft =
      Tween<Offset>(begin: Offset.zero, end: const Offset(-3.0, 0.0))
          .animate(_preparationController);
  late final Animation<Offset> _slideRight =
      Tween<Offset>(begin: Offset.zero, end: const Offset(3.0, 0.0))
          .animate(_preparationController);
  late final Animation<Offset> _slideDown =
      Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 3.0))
          .animate(_preparationController);
  late final Animation<Offset> _slideUp = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -2.5),
  ).animate(_preparationController);

  late final Animation<double> _opacity =
      Tween<double>(begin: 0.0, end: 1.0).animate(_preparationController);

  final ValueNotifier<String> _timeDisplay = ValueNotifier('00:00');
  final ValueNotifier<int> _timerTicker = ValueNotifier(0);
  final NumberFormat _numberFormat = NumberFormat('00');

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _preparationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        timer?.cancel();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final int tick = timer.tick;

          if (tick < 60) {
            _timeDisplay.value = '00:${_numberFormat.format(tick)}';
            _timerTicker.value = tick;
          } else {
            _preparationController.reverse();
          }
        });
      }

      if (status == AnimationStatus.dismissed) {
        timer?.cancel();
        _timerTicker.value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: NartusDimens.padding16, left: NartusDimens.padding16),
              child: CircleButton(
                size: NartusDimens.padding40,
                iconPath: Assets.images.closeIcon,
                semantic: S.current.close,
                onPressed: () => context.pop(),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: NartusDimens.padding16,
                  left: NartusDimens.padding24,
                  right: NartusDimens.padding24),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SlideTransition(
                      position: _slideLeft,
                      child: CircleButton(
                        size: NartusDimens.padding40,
                        iconPath: Assets.images.galleryIcon,
                        semantic: S.current.openDeviceGallery,
                        onPressed: widget.onGalleryTapped,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SlideTransition(
                            position: _slideUp,
                            child: FadeTransition(
                                opacity: _opacity,
                                child: TimeLabel(
                                  display: _timeDisplay,
                                ))),
                        ShutterButton(
                            ticker: _timerTicker,
                            animationController: _preparationController,
                            onShutterTapped: widget.onShutterTapped,
                            onShutterLongPressStart: () {
                              _preparationController.forward();
                              widget.onShutterLongPressStart();
                            },
                            onShutterLongPressEnd: () {
                              timer?.cancel();
                              _timerTicker.value = 0;
                              widget.onShutterLongPressEnd();
                              _preparationController.reverse();
                            }),
                      ],
                    ),
                    SlideTransition(
                      position: _slideRight,
                      child: CircleButton(
                        size: NartusDimens.padding40,
                        iconPath: Assets.images.flipIcon,
                        semantic: S.current.flipCamera,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                const Gap.v16(),
                const Gap.v20(),
                SlideTransition(
                  position: _slideDown,
                  child: Text(
                    S.current.holdToRecord,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: NartusColor.white,
                        ),
                  ),
                )
              ]),
            ),
          )
        ],
      );
}
