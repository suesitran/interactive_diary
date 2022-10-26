part of 'nartus_button.dart';

class _ButtonContent extends StatelessWidget {
  final String label;
  final Widget icon;
  final IconPosition iconPosition;

  const _ButtonContent(
      {required this.label, required this.icon, Key? key, this.iconPosition = IconPosition.left}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: iconPosition == IconPosition.left ? <Widget>[Padding(padding: const EdgeInsets.only(right: 14), child: icon,), Text(label)] : <Widget>[Text(label), Padding(padding: const EdgeInsets.only(left: 14), child: icon,)],
  );
}
