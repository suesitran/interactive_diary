import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:nartus_ui_package/generated/l10n.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:interactive_diary/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  // init Firebase
  await Firebase.initializeApp(
    name: 'InnerME',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ServiceLocator.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppConfigBloc>(
        create: (context) => AppConfigBloc()..add(AppRequestInitialise()),
      ),
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) => ConnectivityBloc()
          ..add(WatchConnectivityEvent())
          ..add(CheckConnectivityEvent()),
      ),
    ],
    child: const _MainApp(),
  ));
}

class _MainApp extends StatefulWidget {
  const _MainApp({Key? key}) : super(key: key);

  @override
  State<_MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<_MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ConnectivityBloc>().add(CheckConnectivityEvent());
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: appRoute,
        title: 'Interactive Diary',
        theme: lightTheme,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          Strings.delegate
        ],
        supportedLocales: [
          ...S.delegate.supportedLocales,
          ...Strings.delegate.supportedLocales,
        ],
        builder: (context, child) {
          if (child != null) {
            final double textScaleFactor =
                MediaQuery.of(context).textScaleFactor;

            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: textScaleFactor.clamp(0.8, 1.25)),
                child: child);
          }

          // return unavailable screen
          return const ScreenUnavailable();
        },
      );
}

class ScreenUnavailable extends StatelessWidget {
  const ScreenUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.current.unavailable),
        ),
        body: Center(
          child: Text(S.current.unavailableScreenDesc),
        ),
      );
}
