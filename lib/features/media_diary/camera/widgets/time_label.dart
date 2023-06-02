import 'package:nartus_ui_package/nartus_ui.dart';

class TimeLabel extends StatelessWidget {
  final ValueNotifier<String> display;

  const TimeLabel({required this.display, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: NartusColor.white),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ValueListenableBuilder(
          valueListenable: display,
          builder: (context, value, child) => Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: NartusColor.red),
          ),
        ),
      );
}
