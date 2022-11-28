import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class NartusAlertDialog extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;
  final String? textButtonText;
  final VoidCallback? onTextButtonSelected;

  const NartusAlertDialog(
      {required this.title,
      required this.content,
      required this.primaryButtonText,
      required this.onPrimaryButtonSelected,
      Key? key,
      this.iconPath,
      this.secondaryButtonText,
      this.onSecondButtonSelected,
      this.textButtonText,
      this.onTextButtonSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (iconPath != null)
            ExcludeSemantics(
                child: Padding(
              padding: const EdgeInsets.only(bottom: NartusDimens.padding24),
              child: SvgPicture.asset(
                iconPath!,
                fit: BoxFit.scaleDown,
                width: NartusDimens.size80,
                height: NartusDimens.size80,
              ),
            )),
          Padding(
              padding: const EdgeInsets.only(bottom: NartusDimens.padding8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: NartusColor.dark),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: NartusDimens.padding40),
              child: Text(
                content,
                textAlign: TextAlign.center,
                maxLines: 4,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: NartusColor.grey),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: NartusDimens.padding10),
              child: NartusButton.primary(
                label: primaryButtonText,
                onPressed: onPrimaryButtonSelected,
              )),
          if (secondaryButtonText != null)
            Padding(
                padding: const EdgeInsets.only(bottom: NartusDimens.padding10),
                child: NartusButton.secondary(
                  label: secondaryButtonText,
                  onPressed: onSecondButtonSelected,
                )),
          if (textButtonText != null)
            NartusButton.text(
              label: textButtonText,
              onPressed: onTextButtonSelected,
            )
        ],
      ),
    );
  }
}

extension IdAlertDialog on BuildContext {
  void showIDAlertDialog(
      {required String title,
      required String content,
      required String primaryButtonText,
      required VoidCallback onPrimaryButtonSelected,
      String? iconPath,
      String? secondaryButtonText,
      VoidCallback? onSecondaryButtonSelected,
      String? textButtonText,
      VoidCallback? onTextButtonSelected,
      bool isDismissible = true}) {
    showDialog(
        context: this,
        builder: (BuildContext builder) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20), bottom: Radius.circular(20))),
            child: WillPopScope(
              onWillPop: () => Future<bool>.value(isDismissible),
              child: NartusAlertDialog(
                iconPath: iconPath,
                title: title,
                content: content,
                primaryButtonText: primaryButtonText,
                onPrimaryButtonSelected: onPrimaryButtonSelected,
                secondaryButtonText: secondaryButtonText,
                onSecondButtonSelected: onSecondaryButtonSelected,
                textButtonText: textButtonText,
                onTextButtonSelected: onTextButtonSelected,
              ),
            ),
          );
        });
  }
}
