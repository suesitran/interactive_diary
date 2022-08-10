import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget) async {
    final Widget wrapper = _MaterialWrapWidget(
      child: widget
    );

    await pumpWidget(wrapper);
    await pump();
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