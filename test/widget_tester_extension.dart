import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget, {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = _MaterialWrapWidget(child: widget);

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }
  }

  Future<void> blocWrapAndPump<B extends StateStreamableSource<Object?>>(B bloc, Widget widget, {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = BlocProvider<B>(
      create: (_) => bloc,
      child: _MaterialWrapWidget(child: widget,),
    );

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
