import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final String locationIconSvg;
  final String? businessName;
  final String? address;
  final double latitude;
  final double longitude;
  final bool isValidLocation;
  final BorderRadiusGeometry? borderRadius;
  final String? semanticBusinessName;
  final String? semanticAddress;
  final String? semanticCoordinate;
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
    this.semanticCoordinate,
  })  : isValidLocation = businessName != null || address != null,
        locationIconSvg = locationIconSvg ?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    left:
                        locationIconSvg.isNotEmpty ? 0 : NartusDimens.padding16,
                    right: NartusDimens.padding16,
                    bottom: NartusDimens.padding16,
                    top: NartusDimens.padding16),
                child: MergeSemantics(
                    child: (() {
                  if (isValidLocation) {
                    if (businessName != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            businessName ?? '',
                            maxLines: 2,
                            semanticsLabel: semanticBusinessName,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(height: 1.8),
                          ),
                          const SizedBox(height: 02),
                          Text(
                            address ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            semanticsLabel: semanticAddress,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(height: 1.8),
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        address ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        semanticsLabel: semanticAddress,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(height: 1.8),
                      );
                    }
                  }
                  return Text(
                    '($latitude, $longitude)',
                    textDirection: TextDirection.ltr,
                    semanticsLabel: semanticCoordinate,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 1.8),
                  );
                }()))),
          ),
        ],
      ),
    );
  }
}
