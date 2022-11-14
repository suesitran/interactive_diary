part of 'nartus_bottom_sheet.dart';

class _NartusPersistentBottomSheet extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String content;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonSelected;
  final String? secondaryButtonText;
  final VoidCallback? onSecondButtonSelected;

  const _NartusPersistentBottomSheet(
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 72),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            iconPath,
            fit: BoxFit.scaleDown,
          ),
          Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: NartusColor.dark)
          ),
          Text(
              content,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: NartusColor.dark)
          ),
          NartusButton.primary(
            label: primaryButtonText,
            onPressed: onPrimaryButtonSelected,
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
