import 'package:flutter/material.dart';

import 'package:nartus_ui_package/dimens/dimens.dart';

class DateLabelView extends StatelessWidget {
  const DateLabelView({
    required this.leadingIcon,
    required this.dateLabel,
    required this.tailIcon,
    Key? key,
    this.leadingIconColor,
    this.leadingIconSemanticLabel,
    this.onLeadingIconPressed,
    this.labelExpansionIcon,
    this.dateSemanticLabel,
    this.tailIconColor,
    this.tailIconSemanticLabel,
    this.onTailIconPressed,
  }) : super(key: key);

  final IconData leadingIcon;
  final Color? leadingIconColor;
  final String? leadingIconSemanticLabel;
  final VoidCallback? onLeadingIconPressed;

  final String dateLabel;
  final IconData? labelExpansionIcon;
  final String? dateSemanticLabel;

  final IconData tailIcon;
  final Color? tailIconColor;
  final String? tailIconSemanticLabel;
  final VoidCallback? onTailIconPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(NartusDimens.padding54)),
      ),
      color: Theme
          .of(context)
          .backgroundColor,
      elevation: NartusDimens.padding4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_leadingIcon(), _mainTitle(), _tailIcon()],
      ),
    );
  }

  Widget _leadingIcon() =>
      LeadingWidget(
        icon: leadingIcon,
        iconColor: leadingIconColor,
        iconSemanticLabel: leadingIconSemanticLabel,
        onPressed: onLeadingIconPressed,
      );

  Widget _mainTitle() =>
      MainTitle(label: dateLabel,
        semanticLabel: dateSemanticLabel,
        expansionIcon: labelExpansionIcon,);

  Widget _tailIcon() =>
      TailIcon(icon: tailIcon,
        onPressed: onTailIconPressed,
        color: tailIconColor,
        semanticLabel: tailIconSemanticLabel,);
}

class LeadingWidget extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? iconSemanticLabel;
  final VoidCallback? onPressed;

  const LeadingWidget({
    this.icon,
    this.iconColor,
    this.iconSemanticLabel,
    this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(
            left: NartusDimens.padding20,
            top: NartusDimens.padding18,
            right: NartusDimens.padding18,
            bottom: NartusDimens.padding18),
        child: IconButton(
          icon: Icon(
            icon,
            color: iconColor,
            semanticLabel: iconSemanticLabel,
          ),
          onPressed: onPressed,
        ),
      );
}

class MainTitle extends StatelessWidget {
  final String? semanticLabel;
  final String label;
  final IconData? expansionIcon;

  const MainTitle(
      {required this.label, this.semanticLabel, this.expansionIcon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Semantics(
        explicitChildNodes: true,
        label: semanticLabel ?? label,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              Text(
                label,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall,
              ),
            if (expansionIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: NartusDimens.padding4),
                child: Icon(expansionIcon),
              )
          ],
        ),
      );
}

class TailIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color;
  final String? semanticLabel;

  const TailIcon({required this.icon, this.onPressed, this.color, this.semanticLabel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconButton(
      onPressed: onPressed,
      icon: Icon(icon,
          color: color,
          semanticLabel: semanticLabel,
          size: 40),
    ),
  );
}



