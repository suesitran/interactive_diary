import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

class TimeLabel extends StatelessWidget {
  const TimeLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: NartusColor.white),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Text(
          '00:15',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: NartusColor.red),
        ),
      );
}
