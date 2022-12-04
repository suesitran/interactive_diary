import 'package:go_router/go_router.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/main_app_screen.dart';

export 'package:go_router/go_router.dart';

const String idHomeRoute = '/';
const String noConnectionRoute = '/noConnection';

final GoRouter appRoute = GoRouter(
  // main routes that can be accessed directly at app launch
  routes: <GoRoute>[
    // Home screen
    GoRoute(
      path: idHomeRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const MainAppScreen();
      },
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
