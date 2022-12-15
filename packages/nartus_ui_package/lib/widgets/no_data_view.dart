import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  final String text;
  const NoDataView({Key? key, this.text = 'No data found'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
