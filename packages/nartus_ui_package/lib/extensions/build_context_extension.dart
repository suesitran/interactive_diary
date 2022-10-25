import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

extension BuildContextExtension on BuildContext {
  void showDialogAdaptive(
      {Widget? title,
      Widget? content,
      List<Widget>? actions,
      bool barrierDismissible = false}) {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        showCupertinoDialog(
            context: this,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: actions ?? <Widget>[],
                  insetAnimationCurve: Curves.easeIn,
                ),
            barrierDismissible: barrierDismissible);
      } else {
        showDialog(
            context: this,
            builder: (BuildContext context) => AlertDialog(
                  title: title,
                  content: content,
                  actions: actions ?? <Widget>[],
                ),
            barrierDismissible: barrierDismissible);
      }
    });
  }
}
