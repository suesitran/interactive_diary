import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/generated/l10n.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget,
      {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = _MaterialWrapWidget(child: widget);

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }
  }

  Future<void> blocWrapAndPump<B extends StateStreamableSource<Object?>>(
      B bloc, Widget widget,
      {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = BlocProvider<B>(
      create: (_) => bloc,
      child: _MaterialWrapWidget(
        child: widget,
      ),
    );

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }

  Future<void> multiBlocWrapAndPump(
      List<BlocProvider<StateStreamableSource<Object?>>> providers,
      // List<BlocProvider<<B extends StateStreamableSource<Object?>>> providers,
      Widget widget,
      {bool infiniteAnimationWidget = false}) async {
    final Widget wrapper = MultiBlocProvider(
        providers: providers,
        child: _MaterialWrapWidget(
          child: widget,
        ));

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }
}

class _MaterialWrapWidget extends StatelessWidget {
  final Widget child;

  const _MaterialWrapWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
    );
  }
}
