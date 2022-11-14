part of 'nartus_bottom_sheet.dart';

class _NartusModalBottomSheet extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;

  const _NartusModalBottomSheet(
      {Key? key,
      this.iconPath,
      required this.title,
      required this.content,
      required this.primaryButtonText,
      required this.onPrimaryButtonSelected,
      this.secondaryButtonText,
      this.onSecondButtonSelected})
      : super(key: key);

  @override
  Widget build(BuildContext) {
    return Material();
  }
}