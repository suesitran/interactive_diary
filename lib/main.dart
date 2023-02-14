import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/connectivity/bloc/connection_screen_bloc.dart';
import 'package:interactive_diary/bloc/storage/storage_bloc.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:interactive_diary/bloc/get_contents/get_contents_bloc.dart';
import 'package:interactive_diary/firebase_options.dart';
import 'package:interactive_diary/generated/l10n.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

// ignore_for_file: always_specify_types
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AppConfigBloc>(
        create: (context) => AppConfigBloc()
        ..initialise(),
      ),
      BlocProvider<LocationBloc>(
        create: (BuildContext context) => LocationBloc(),
      ),
      BlocProvider<GetContentsBloc>(
        create: (BuildContext context) => GetContentsBloc(),
      ),
      BlocProvider<ConnectivityBloc>(
        create: (BuildContext context) => ConnectivityBloc(),
      ),
      BlocProvider<ConnectionScreenBloc>(
        create: (BuildContext context) => ConnectionScreenBloc(),
      ),
      BlocProvider<StorageBloc>(
        create: (_) => StorageBloc(),
      )
    ],
    child: MultiBlocListener(
      listeners: [
        BlocListener<AppConfigBloc, AppConfigState>(
          listener: (context, state) {

          },
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
                child: child);
          }

          // return unavailable screen
          return const ScreenUnavailable();
        },
      ),
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
