import 'package:flutter/material.dart';

class IDButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool? isBusy;
  const IDButton({required this.text, required this.onPressed, Key? key, this.isBusy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const SizedBox(),
      onPressed: onPressed,
      label: isBusy! ? const CircularProgressIndicator() : Text(text),
      style: TextButton.styleFrom(
          maximumSize: const Size(double.infinity, 46),
          minimumSize: const Size(200, 46),
          elevation: 1,
          primary: Colors.black),
    );
  }
}