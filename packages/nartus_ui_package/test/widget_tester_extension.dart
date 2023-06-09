import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nartus_ui_package/generated/l10n.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapMaterialAndPump(Widget widget,
      {bool infiniteAnimationWidget = false, ThemeData? theme}) async {
    final Widget wrapper = _MaterialWrapWidget(
      theme: theme,
      child: widget,
    );

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
  final ThemeData? theme;

  const _MaterialWrapWidget({required this.child, Key? key, this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: theme,
        localizationsDelegates: const [Strings.delegate],
        supportedLocales: Strings.delegate.supportedLocales,
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
