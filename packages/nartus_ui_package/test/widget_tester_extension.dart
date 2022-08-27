import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapMaterialAndPump(Widget widget,
      {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = _MaterialWrapWidget(child: widget);

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }
  }

  Future<void> wrapCupertinoAndPump(Widget widget,
      {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = _CupertinoWrapWidget(child: widget);

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }
  }
}

class _MaterialWrapWidget extends StatelessWidget {
  final Widget child;

  const _MaterialWrapWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: child,
        ),
      );
}

class _CupertinoWrapWidget extends StatelessWidget {
  final Widget child;

  const _CupertinoWrapWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoApp(
    home: CupertinoPageScaffold(
      child: child,
    ),
  );
}
