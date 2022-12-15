import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';

class DateLabelView extends StatelessWidget {
  final String dateLabel;
  final String profileSemanticLabel;
  const DateLabelView(
      {required this.dateLabel, required this.profileSemanticLabel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: NartusDimens.padding10,
            horizontal: NartusDimens.padding24),
        child: Card(
          color: Theme.of(context).colorScheme.background,
          elevation: NartusDimens.elevation10,
          shadowColor: NartusColor.grey.withOpacity(0.3),
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(NartusDimens.padding54)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CalendarLabelView(dateLabel: dateLabel),
              ProfileIconView(
                semanticLabel: profileSemanticLabel,
              ),
            ],
          ),
        ),
      );
}

class CalendarLabelView extends StatelessWidget {
  final String dateLabel;
  const CalendarLabelView({required this.dateLabel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
        focusable: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: NartusDimens.padding18,
                  horizontal: NartusDimens.padding20),
              child: SvgPicture.asset(
                Assets.images.calendar,
                width: 20,
                height: 20,
              ),
            ),
            Text(
              dateLabel,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(NartusDimens.padding10),
              child: SvgPicture.asset(Assets.images.arrowDown),
            )
          ],
        ),
      );
}

class ProfileIconView extends StatelessWidget {
  final String semanticLabel;
  const ProfileIconView({required this.semanticLabel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Semantics(
        label: semanticLabel,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(NartusDimens.padding8),
            child: SvgPicture.asset(
              Assets.images.anonymous,
              width: 40,
              height: 40,
            ),
          ),
        ),
      );
}
