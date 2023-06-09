import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:nartus_ui_package/generated/l10n.dart';

extension WidgetExtension on WidgetTester {
  Future<void> wrapAndPump(Widget widget,
      {bool infiniteAnimationWidget = false,
      bool useRouter = false,
      String? targetRoute}) async {
    final Widget wrapper = _MaterialWrapWidget(
      useRouter: useRouter,
      targetRoute: targetRoute,
      child: widget,
    );

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    if (useRouter) {
      await tap(find.text('Start testing'));
      if (infiniteAnimationWidget) {
        await pump();
      } else {
        await pumpAndSettle();
      }
    }
  }

  Future<void> blocWrapAndPump<B extends StateStreamableSource<Object?>>(
      B bloc, Widget widget,
      {bool infiniteAnimationWidget = false,
      bool useRouter = false,
      String? targetRoute}) async {
    final Widget wrapper = BlocProvider<B>(
      create: (_) => bloc,
      child: _MaterialWrapWidget(
          useRouter: useRouter, targetRoute: targetRoute, child: widget),
    );

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    if (useRouter) {
      await tap(find.text('Start testing'));
      if (infiniteAnimationWidget) {
        await pump();
      } else {
        await pumpAndSettle();
      }
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }

  Future<void> multiBlocWrapAndPump(
      List<BlocProvider<StateStreamableSource<Object?>>> providers,
      // List<BlocProvider<<B extends StateStreamableSource<Object?>>> providers,
      Widget widget,
      {bool infiniteAnimationWidget = false,
      bool useRouter = false,
      String? targetRoute}) async {
    final Widget wrapper = MultiBlocProvider(
        providers: providers,
        child: _MaterialWrapWidget(
          useRouter: useRouter,
          targetRoute: targetRoute,
          child: widget,
        ));

    await pumpWidget(wrapper);
    if (infiniteAnimationWidget) {
      await pump();
    } else {
      await pumpAndSettle();
    }

    if (useRouter) {
      await tap(find.text('Start testing'));
      if (infiniteAnimationWidget) {
        await pump();
      } else {
        await pumpAndSettle();
      }
    }

    await pumpFrames(wrapper, const Duration(milliseconds: 16));
  }
}

class _MaterialWrapWidget extends StatelessWidget {
  final Widget child;
  final bool useRouter;
  final String? targetRoute;

  const _MaterialWrapWidget(
      {required this.child, this.useRouter = false, this.targetRoute, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useRouter
        ? MaterialApp.router(
            routerConfig: GoRouter(routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => Scaffold(
                  body: Center(
                    child: TextButton(
                      child: const Text('Start testing'),
                      onPressed: () => GoRouter.of(context).push('/target'),
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: '/target',
                builder: (context, state) => child,
              ),
              if (targetRoute != null)
                GoRoute(
                  path: targetRoute!,
                  builder: (context, state) => Scaffold(
                    body: Center(
                      child: Text(targetRoute!),
                    ),
                  ),
                )
            ]),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              S.delegate,
              Strings.delegate
            ],
            supportedLocales: [
              ...S.delegate.supportedLocales,
              ...Strings.delegate.supportedLocales
            ],
            locale: const Locale('en'),
          )
        : MaterialApp(
            home: Scaffold(
              body: child,
            ),
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              S.delegate,
              Strings.delegate
            ],
            supportedLocales: [
              ...S.delegate.supportedLocales,
              ...Strings.delegate.supportedLocales
            ],
            locale: const Locale('en'),
          );
  }
}
