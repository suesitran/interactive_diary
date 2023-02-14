part of 'nartus_button.dart';

class _ButtonContent extends StatelessWidget {
  final String label;
  final String icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;
  final bool isEnable;

  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.buttonType,
    required this.isEnable,
    Key? key,
    this.iconPosition = IconPosition.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: iconPosition == IconPosition.left
            ? <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: NartusDimens.padding14),
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        isEnable
                            ? _getEnableColor(buttonType)
                            : _getDisableColor(buttonType),
                        BlendMode.srcIn),
                  ),
                ),
                Text(label)
              ]
            : <Widget>[
                Text(label),
                Padding(
                  padding: const EdgeInsets.only(left: NartusDimens.padding14),
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        isEnable
                            ? _getEnableColor(buttonType)
                            : _getDisableColor(buttonType),
                        BlendMode.srcIn),
                  ),
                )
              ],
      );
  Color _getEnableColor(ButtonType type) =>
      type == ButtonType.primary ? NartusColor.white : NartusColor.primary;
  Color _getDisableColor(ButtonType type) => type == ButtonType.primary
      ? NartusColor.white
      : NartusColor.grey.withOpacity(0.5);
}
