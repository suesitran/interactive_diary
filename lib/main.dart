import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/bloc/no_connection_screen/connection_screen_bloc.dart';
import 'package:interactive_diary/bloc/storage/storage_bloc.dart';
import 'package:interactive_diary/route/map_route.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:interactive_diary/firebase_options.dart';
import 'package:interactive_diary/generated/l10n.dart';

// ignore_for_file: always_specify_types
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LocationBloc>(
        create: (BuildContext context) => LocationBloc(),
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
    child: MaterialApp.router(
      routerConfig: appRoute,
      title: 'Interactive Diary',
      theme: lightTheme,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    ),
  ));
}
