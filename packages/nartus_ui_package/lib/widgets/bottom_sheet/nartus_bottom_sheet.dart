import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class NartusBottomSheet extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;
  final String? textButtonText;
  final VoidCallback? onTextButtonSelected;

  const NartusBottomSheet(
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
        padding: const EdgeInsets.fromLTRB(32, 40, 32, 58),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (iconPath != null)
                ExcludeSemantics(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: NartusDimens.padding24),
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
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: NartusColor.dark),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: NartusDimens.padding24),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: NartusColor.grey),
                  )),
              Padding(
                  padding:
                      const EdgeInsets.only(bottom: NartusDimens.padding16),
                  child: SizedBox(
                    width: double.infinity,
                    child: NartusButton.primary(
                      label: primaryButtonText,
                      onPressed: onPrimaryButtonSelected,
                    ),
                  )),
              if (secondaryButtonText != null)
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: NartusDimens.padding16),
                    child: SizedBox(
                      width: double.infinity,
                      child: NartusButton.secondary(
                        label: secondaryButtonText,
                        onPressed: onSecondButtonSelected,
                      ),
                    )),
              if (textButtonText != null)
                SizedBox(
                    width: double.infinity,
                    child: NartusButton.text(
                      label: textButtonText,
                      onPressed: onTextButtonSelected,
                    )),
            ],
          ),
        ));
  }
}

extension IdBottomSheet on BuildContext {
  void showIDBottomSheet(
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
    showModalBottomSheet(
        context: this,
        isDismissible: isDismissible,
        enableDrag: isDismissible,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext builder) {
          return WillPopScope(
            onWillPop: () => Future<bool>.value(isDismissible),
            child: NartusBottomSheet(
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
          );
        });
  }
}
