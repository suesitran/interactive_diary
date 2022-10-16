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
      color: Theme.of(context).backgroundColor,
      elevation: NartusDimens.padding4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[_leadingIcon(), _mainTitle(), _tailIcon()],
      ),
    );
  }

  Widget _leadingIcon() => Padding(
        padding: const EdgeInsets.only(
            left: NartusDimens.padding20,
            top: NartusDimens.padding18,
            right: NartusDimens.padding18,
            bottom: NartusDimens.padding18),
        child: IconButton(
          icon: Icon(
            leadingIcon,
            color: leadingIconColor,
            semanticLabel: leadingIconSemanticLabel,
          ),
          onPressed: onLeadingIconPressed,
        ),
      );

  Widget _mainTitle() => Builder(
      builder: (BuildContext context) => Semantics(
            explicitChildNodes: true,
            label: dateSemanticLabel ?? dateLabel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  dateLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (labelExpansionIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(left: NartusDimens.padding4),
                    child: Icon(labelExpansionIcon),
                  )
              ],
            ),
          ));

  Widget _tailIcon() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onTailIconPressed,
          icon: Icon(tailIcon,
              color: tailIconColor,
              semanticLabel: tailIconSemanticLabel,
              size: 40),
        ),
      );
}
