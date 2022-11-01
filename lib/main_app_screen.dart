import 'package:flutter/material.dart';

import 'package:interactive_diary/features/home/home_screen.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
        child: const IDHome());
  }
}
