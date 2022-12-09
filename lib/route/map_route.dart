import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/features/home/home_screen.dart';

export 'package:go_router/go_router.dart';

const String idHomeRoute = '/';
const String noConnectionRoute = '/noConnection';
const String writeDiaryRoute = '/writeDiary';

final GoRouter appRoute = GoRouter(
  // main routes that can be accessed directly at app launch
  routes: <GoRoute>[
    // Home screen
    GoRoute(
      path: '/',
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
  ],
);
