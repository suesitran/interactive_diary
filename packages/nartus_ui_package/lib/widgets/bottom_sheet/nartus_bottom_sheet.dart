import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nartus_ui_package/theme/nartus_theme.dart';
import 'package:nartus_ui_package/widgets/buttons/nartus_button.dart';

part 'nartus_modal_bottom_sheet.dart';
part 'nartus_persistent_bottom_sheet.dart';

enum BottomSheetType {modal, persistent}

class NartusBottomSheet extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;
  final BottomSheetType bottomSheetType;

  const NartusBottomSheet.modal( {
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.onPrimaryButtonSelected,
    Key? key,
    this.iconPath,
    this.secondaryButtonText,
    this.onSecondButtonSelected})
      : bottomSheetType = BottomSheetType.modal,
        super(key: key);

  const NartusBottomSheet.persistent( {
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.onPrimaryButtonSelected,
    Key? key,
    this.iconPath,
    this.secondaryButtonText,
    this.onSecondButtonSelected})
      : bottomSheetType = BottomSheetType.persistent,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (bottomSheetType) {
      case BottomSheetType.modal:
        return _NartusModalBottomSheet(
          iconPath: iconPath,
          title: title,
          content: content,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonSelected: onPrimaryButtonSelected,
          secondaryButtonText: secondaryButtonText,
          onSecondButtonSelected: onSecondButtonSelected,
        );

      case BottomSheetType.persistent:
        return _NartusPersistentBottomSheet(
          iconPath: iconPath,
          title: title,
          content: content,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonSelected: onPrimaryButtonSelected,
          secondaryButtonText: secondaryButtonText,
          onSecondButtonSelected: onSecondButtonSelected,
        );
    }
  }
}