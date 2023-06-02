import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/gaps.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../_shared/widgets/buttons.dart';

class CameraControlsLayer extends StatelessWidget {
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
                    Builder(builder: (context) {
                      return CircleButton(
                        size: NartusDimens.padding40,
                        iconPath: Assets.images.galleryIcon,
                        semantic: S.current.openDeviceGallery,
                        onPressed: onGalleryTapped,
                      );
                    }),
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
                              onTap: onShutterTapped,
                              onLongPressStart: (details) {
                                onShutterLongPressStart();
                              },
                              onLongPressEnd: (details) {
                                onShutterLongPressEnd();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleButton(
                      size: NartusDimens.padding40,
                      iconPath: Assets.images.flipIcon,
                      semantic: S.current.flipCamera,
                      onPressed: () {},
                    )
                  ],
                ),
                const Gap.v16(),
                const Gap.v20(),
                Text(
                  S.current.holdToRecord,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: NartusColor.white,
                      ),
                )
              ]),
            ),
          )
        ],
      );
}
