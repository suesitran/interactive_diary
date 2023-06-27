import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/generated/l10n.dart';

class MapTypeBottomSheet extends StatelessWidget {
  final MapType currentType;
  const MapTypeBottomSheet({required this.currentType, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.mapType,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: NartusColor.dark),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MapTypeDisplay(
                    typePath: Assets.images.mapTypeDefault,
                    name: S.current.mapTypeDefault,
                    isSelected: currentType == MapType.normal,
                    onTap: () {
                      Navigator.of(context).pop(MapType.normal);
                    },
                  ),
                  MapTypeDisplay(
                    typePath: Assets.images.mapTypeSatellite,
                    name: S.current.mapTypeSatellite,
                    isSelected: currentType == MapType.satellite,
                    onTap: () {
                      Navigator.of(context).pop(MapType.satellite);
                    },
                  ),
                  MapTypeDisplay(
                    typePath: Assets.images.mapTypeTerrain,
                    name: S.current.mapTypeTerrain,
                    isSelected: currentType == MapType.terrain,
                    onTap: () {
                      Navigator.of(context).pop(MapType.terrain);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      );
}

class MapTypeDisplay extends StatelessWidget {
  final String typePath;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const MapTypeDisplay(
      {required this.typePath,
      required this.name,
      required this.isSelected,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(NartusDimens.radius12),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(NartusDimens.radius12),
                  border: Border.all(
                      color:
                          isSelected ? NartusColor.primary : NartusColor.white,
                      width: 2,
                      style: BorderStyle.solid)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(NartusDimens.radius10),
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset(
                    typePath,
                    width: 99,
                    height: 70,
                  )),
            ),
            Text(name, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      );
}

extension MapTypeExtension on BuildContext {
  void showMapTypeBottomSheet(
      MapType currentType, Function(MapType) onSelected) {
    showModalBottomSheet(
        context: this,
        isDismissible: true,
        enableDrag: true,
        showDragHandle: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(NartusDimens.radius24),
                topRight: Radius.circular(NartusDimens.radius24))),
        backgroundColor: NartusColor.white,
        builder: (context) => MapTypeBottomSheet(
              currentType: currentType,
            )).then((value) => onSelected(value));
  }
}
