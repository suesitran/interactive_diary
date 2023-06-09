import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/generated/l10n.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final String locationIconSvg;
  final String? businessName;
  final String? address;
  final double latitude;
  final double longitude;
  final BorderRadiusGeometry? borderRadius;
  final String? semanticBusinessName;
  final String? semanticAddress;
  const LocationView({
    required this.latitude,
    required this.longitude,
    Key? key,
    this.address,
    this.businessName,
    this.borderRadius,
    String? locationIconSvg,
    this.semanticBusinessName,
    this.semanticAddress,
  })  : locationIconSvg = locationIconSvg ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Container(
        decoration: BoxDecoration(
            gradient: NartusColor.gradient, borderRadius: borderRadius),
        child: Row(

            /// Why must specify textDirection ?
            /// Using this widget works fine without textDirection, but failed when testing.
            /// in order to pass the tests, we have to specify textDirection.
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (locationIconSvg.isNotEmpty) ...<Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      NartusDimens.padding16,
                      NartusDimens.padding24,
                      NartusDimens.padding12,
                      NartusDimens.padding16),
                  child: SvgPicture.asset(
                    locationIconSvg,
                    width: 13,
                    height: 15,
                  ),
                ),
              ],
              Flexible(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: locationIconSvg.isNotEmpty
                              ? 0
                              : NartusDimens.padding16,
                          right: NartusDimens.padding16,
                          bottom: NartusDimens.padding16,
                          top: NartusDimens.padding16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: [
                          if (businessName != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                businessName!,
                                maxLines: 2,
                                semanticsLabel: semanticBusinessName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(height: 1.8),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          Text(
                            address ?? '($latitude, $longitude)',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(height: 1.8),
                            semanticsLabel: address == null
                                ? Strings.current
                                    .locationViewLatLngAlly(latitude, longitude)
                                : semanticAddress,
                            textDirection: TextDirection.ltr,
                          )
                        ],
                      ))),
            ]),
      ),
    );
  }
}
