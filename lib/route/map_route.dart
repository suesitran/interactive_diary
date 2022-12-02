import 'package:go_router/go_router.dart';
import 'package:interactive_diary/features/writediary/write_diary_screen.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_ui_package/nartus_ui.dart';

import 'package:interactive_diary/main_app_screen.dart';

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
        return const MainAppScreen();
      },
    ),
    GoRoute(
      path: writeDiaryRoute,
      builder: (BuildContext context, GoRouterState state) {
        return WriteDiaryScreen(latLng: state.extra as LatLng);
      },
    ),
    // add other 1st level route
  ],
);
