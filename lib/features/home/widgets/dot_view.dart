import 'package:nartus_ui_package/nartus_ui.dart';

class DotView extends StatelessWidget {
  const DotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 3,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: NartusColor.grey,
      ),
    );
  }
}
