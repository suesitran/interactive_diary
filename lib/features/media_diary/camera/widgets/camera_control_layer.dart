import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/gaps.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../_shared/widgets/buttons.dart';

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

class _CameraControlsLayerState extends State<CameraControlsLayer> with TickerProviderStateMixin {

  late final AnimationController _preparationController = AnimationController(vsync: this)
      ..duration = const Duration(seconds: 3);

  late final Animation<Offset> _slideLeft = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-3.0, 0.0)
  ).animate(_preparationController);
  late final Animation<Offset> _slideRight = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(3.0, 0.0)
  ).animate(_preparationController);
  late final Animation<Offset> _slideDown = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 3.0)
  ).animate(_preparationController);

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
                    Semantics(
                      button: true,
                      enabled: true,
                      excludeSemantics: true,
                      explicitChildNodes: false,
                      label: S.current.captureMediaButton,
                      child: Container(
                        width: NartusDimens.padding40 +
                            NartusDimens.padding32 +
                            NartusDimens.padding4,
                        height: NartusDimens.padding40 +
                            NartusDimens.padding32 +
                            NartusDimens.padding4,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: NartusColor.white,
                                width: NartusDimens.padding4),
                            color: Colors.transparent),
                        padding: const EdgeInsets.all(NartusDimens.padding2),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: NartusColor.white, width: 4),
                              color: Colors.white),
                          child: Material(
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: widget.onShutterTapped,
                              onLongPressStart: (details) {
                                _preparationController.forward();
                                widget.onShutterLongPressStart();
                              },
                              onLongPressEnd: (details) {
                                widget.onShutterLongPressEnd();
                              },
                            ),
                          ),
                        ),
                      ),
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
