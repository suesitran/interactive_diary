import 'package:flutter/material.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/features/camera/widgets/buttons.dart';


class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: NartusColor.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                  decoration: const BoxDecoration(
                    color: NartusColor.secondaryContainer,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(NartusDimens.padding24),
                      bottomRight: Radius.circular(NartusDimens.padding24),
                    ),
                    image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg?cs=srgb&dl=pexels-tyler-nix-2396220.jpg&fm=jpg',
                          ))
                  ),
                ),
                Positioned(
                    top: NartusDimens.padding40 + NartusDimens.padding4,
                    left: NartusDimens.padding16,
                    child: CircleButton(
                      size: NartusDimens.padding40,
                      iconPath: Assets.images.closeIcon,
                      semantic: S.current.close,
                      onPressed: () => context.pop(),
                    )),
              ],
            ),
            Expanded(
              child: Center(
                child: NartusButton.primary(
                  label: S.current.save,
                  onPressed: () {},
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}