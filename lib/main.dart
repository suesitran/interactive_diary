import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/features/connectivity/no_connection_screen.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:interactive_diary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  // init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppConfigBloc>(
        create: (context) => AppConfigBloc()..add(AppRequestInitialise()),
      ),
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) => ConnectivityBloc()
          ..add(WatchConnectivityEvent()),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: appRoute,
      title: 'Interactive Diary',
      theme: lightTheme,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        if (child != null) {
          final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
              child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
                builder: (context, state) {
                  if (state is DisconnectedState) {
                    return const NoConnectionScreen();
                  }

                  return child;
                },
              ));
        }

        // return unavailable screen
        return const ScreenUnavailable();
      },
    ),
  ));
}

class ScreenUnavailable extends StatelessWidget {
  const ScreenUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).unavailable),
        ),
        body: Center(
          child: Text(S.of(context).unavailableScreenDesc),
        ),
      );
}
