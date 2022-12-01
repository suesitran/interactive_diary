import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  const ErrorView({Key? key, this.error = 'Something has happened.'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(error, style: Theme.of(context).textTheme.bodyMedium,);
  }
}
