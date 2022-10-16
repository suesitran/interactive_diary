import 'package:flutter/material.dart';
import 'package:nartus_ui_package/widgets/date_label/date_label_view.dart';

class DateLabelDemoScreen extends StatelessWidget {
  const DateLabelDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Label demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          DateLabelView(
            leadingIcon: Icons.calendar_month,
            dateLabel: '20 August 2022',
            labelExpansionIcon: Icons.arrow_drop_down,
            tailIcon: Icons.account_circle,
          )
        ],
      ),
    );
  }
}
