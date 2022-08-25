import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

extension BuildContextExtension on BuildContext {
  void showDialogAdaptive(
      {Widget? title,
      Widget? content,
      List<Widget>? actions,
      bool barrierDismissible = false}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        showCupertinoDialog(
            context: this,
            builder: (context) => CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: actions ?? [],
                  insetAnimationCurve: Curves.easeIn,
                ),
            barrierDismissible: barrierDismissible);
      } else {
        showDialog(
            context: this,
            builder: (context) => AlertDialog(
                  title: title,
                  content: content,
                  actions: actions ?? [],
                ),
            barrierDismissible: barrierDismissible);
      }
    });
  }
}
