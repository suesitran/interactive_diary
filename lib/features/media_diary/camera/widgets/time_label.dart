import 'package:intl/intl.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class TimeLabel extends StatelessWidget {
  final AnimationController controller;

  final NumberFormat numberFormat = NumberFormat('00');

  TimeLabel({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: NartusColor.white),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Text(
            _toDisplayValue(controller.value),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: NartusColor.red),
          ),
        ),
      );

  String _toDisplayValue(double value) {
    int seconds = (value * 60).ceil();
    int minutes = seconds < 60 ? 0 : 1;
    if (seconds == 60) {
      seconds = 0;
    }
    return '${numberFormat.format(minutes)}:${numberFormat.format(seconds)}';
  }
}
