import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_diary/gen/assets.gen.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';

class DateLabelView extends StatelessWidget {
  final String dateLabel;
  const DateLabelView({required this.dateLabel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  Padding(
      padding: const EdgeInsets.symmetric(vertical: NartusDimens.padding10, horizontal: NartusDimens.padding24),
      child: Card(
        color: Theme.of(context).colorScheme.background,
        elevation: NartusDimens.elevation4,
        shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(NartusDimens.padding54)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CalendarLabelView(dateLabel: dateLabel),
            const ProfileIconView(),
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
  Widget build(BuildContext context) => Row(
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
          Text(dateLabel, style: Theme.of(context).textTheme.titleSmall,)
        ],
      );
}

class ProfileIconView extends StatelessWidget {
  const ProfileIconView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(NartusDimens.padding8),
        child: SvgPicture.asset(
          Assets.images.anonymous,
          width: 40,
          height: 40,
        ),
      );
}
