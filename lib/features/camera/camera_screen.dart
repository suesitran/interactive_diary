import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:interactive_diary/route/route_extension.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/features/camera/widgets/buttons.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg?cs=srgb&dl=pexels-tyler-nix-2396220.jpg&fm=jpg',
                ))),
          ),
          Positioned(
            top: 0,
            left: NartusDimens.padding16,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: NartusDimens.padding16),
                child: CircleButton(
                  size: NartusDimens.padding40,
                  iconPath: Assets.images.closeIcon,
                  semantic: S.current.close,
                  onPressed: () => context.pop(),
                ),
              ),
            )),          
          Positioned(
            left: 0, right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: NartusDimens.padding16),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleButton(
                        size: NartusDimens.padding40,
                        iconPath: Assets.images.galleryIcon,
                        semantic: S.current.openDeviceGallery,
                        onPressed: () {
                          
                        },
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
                                border: Border.all(color: NartusColor.white, width: 4),
                                color: Colors.white),
                            child: NartusButton.text(
                              label: '',
                              onPressed: () => context.gotoPreviewMediaScreen(),
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
            ),
          )
        ],
      )
    );
  }
}