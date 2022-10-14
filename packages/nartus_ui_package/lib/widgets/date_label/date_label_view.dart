import 'package:flutter/material.dart';

import '../../dimens/dimens.dart';

class DateLabelView extends StatelessWidget {
  const DateLabelView({Key? key,
  required this.leadingIcon, this.leadingIconColor, this.leadingIconSemanticLabel, required this.dateLabel, this.labelExpansionIcon, required this.tailIcon}) : super(key: key);

  final IconData leadingIcon;
  final Color? leadingIconColor;
  final String? leadingIconSemanticLabel;

  final String dateLabel;
  final IconData? labelExpansionIcon;

  final IconData tailIcon;

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
        children: [
          _leadingIcon(),
          _mainTitle(),
          _tailIcon()
        ],
      ),
    );
  }

  Widget _leadingIcon() => Padding(
    padding: const EdgeInsets.only(
        left: NartusDimens.padding20,
        top: NartusDimens.padding18,
        right: NartusDimens.padding18,
        bottom: NartusDimens.padding18
    ),
    child: Icon(leadingIcon, color: leadingIconColor, semanticLabel: leadingIconSemanticLabel,),
  );

  Widget _mainTitle() => Builder(builder: (context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        dateLabel,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      if (labelExpansionIcon != null)
        Padding(padding: const EdgeInsets.only(left: NartusDimens.padding4), child: Icon(labelExpansionIcon),)
    ],
  ));

  Widget _tailIcon() => Padding(padding: EdgeInsets.all(8.0), child: Icon(tailIcon, size: 40), );
}
