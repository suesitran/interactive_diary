import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final String currentLocation;
  const LocationView({required this.currentLocation, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: NartusColor.gradient),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(
                NartusDimens.padding16,
                NartusDimens.padding16,
                NartusDimens.padding8,
                NartusDimens.padding16),
            child: SvgPicture.asset(
              Assets.images.idLocationIcon,
              width: 13,
              height: 15,
            ),
          ),
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.only(
                      right: NartusDimens.padding16,
                      bottom: NartusDimens.padding16,
                      top: NartusDimens.padding16),
                  child: Text(
                    currentLocation,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ))),
        ],
      ),
    );
  }
}
