import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';
import 'package:interactive_diary/features/splash/splash_screen.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:interactive_diary/features/home/home_screen.dart';

export 'package:go_router/go_router.dart';

const String splash = '/';
const String idHomeRoute = '/home';
const String noConnectionRoute = '/noConnection';
const String writeDiaryRoute = '/writeDiary';

final GoRouter appRoute = GoRouter(
  // main routes that can be accessed directly at app launch
  routes: <GoRoute>[
    // splash screen
    GoRoute(path: splash,
    builder: (BuildContext context, GoRouterState state) => const SplashScreen()),
    // Home screen
    GoRoute(
      path: idHomeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const IDHome();
      },
    ),
    GoRoute(
      path: writeDiaryRoute,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<Offset>(
              child: WriteDiaryScreen(latLng: state.extra as LatLng),
              transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) =>
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  )),
    ),
    // add other 1st level route
    //no connection screen
    GoRoute(
      path: noConnectionRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const NoConnectionScreen();
      },
    ),
  ],
);
