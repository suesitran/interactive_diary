import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/dimens/dimens.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

class NartusBottomSheet extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;

  const NartusBottomSheet(
      {required this.title,
      required this.content,
      required this.primaryButtonText,
      required this.onPrimaryButtonSelected,
      Key? key,
      this.iconPath,
      this.secondaryButtonText,
      this.onSecondButtonSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 58),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: NartusColor.dark),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: NartusDimens.padding24),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: NartusColor.dark),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: NartusDimens.padding30),
            child: NartusButton.primary(
              label: primaryButtonText,
              onPressed: onPrimaryButtonSelected,
            ),
          ),
          NartusButton.secondary(
            label: secondaryButtonText,
            onPressed: onSecondButtonSelected,
          )
        ],
      ),
    );
  }
}

extension IdBottomSheet on BuildContext {
  void showIDBottomSheet(
      {required String title,
      required String content,
      required String primaryBtnText,
      required VoidCallback onPrimaryBtnSelected,
      String? iconPath,
      String? secondaryBtnText,
      VoidCallback? onSecondaryBtnSelected,
      bool isDismissible = true}) {
    showModalBottomSheet(
        context: this,
        isDismissible: isDismissible,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
          )
        ),
        builder: (BuildContext builder) {
          return NartusBottomSheet(
            iconPath: iconPath,
            title: title,
            content: content,
            primaryButtonText: primaryBtnText,
            onPrimaryButtonSelected: onPrimaryBtnSelected,
            secondaryButtonText: secondaryBtnText,
            onSecondButtonSelected: onSecondaryBtnSelected,
          );
        });
  }
}
