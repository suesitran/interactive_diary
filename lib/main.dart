import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:interactive_diary/route/map_route.dart' as routes;
import 'package:firebase_core/firebase_core.dart';
import 'package:interactive_diary/firebase_options.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(MaterialApp(
    home: BlocProvider<LocationBloc>(
      create: (BuildContext context) => LocationBloc(),
      child: const IDHome(),
    ),
    title: 'Interactive Diary',
    theme: lightTheme,
    routes: routes.appRoute,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      S.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
  ));
}
