import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/main_app_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_tester_extension.dart';
import 'main_test.mocks.dart';

@GenerateMocks(<Type>[LocationBloc, ConnectivityBloc])
void main() {
  final MockLocationBloc locationBloc = MockLocationBloc();
  final MockConnectivityBloc connectivityBloc = MockConnectivityBloc();

  setUpAll(() {
    when(locationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022')));
    when(locationBloc.state).thenAnswer(
        (_) => LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022'));
    when(connectivityBloc.stream).thenAnswer((_) => Stream<ConnectivityState>.value(ConnectedState()));
    when(connectivityBloc.state).thenAnswer((_) => ConnectedState());
  });

  group('Test MediaQuery for TextScaleFactor', () {
    testWidgets('given when MainPage is shown, then MediaQuery widget is used',
        (WidgetTester widgetTester) async {
      const MainAppScreen widget = MainAppScreen();

      await widgetTester.multiBlocWrapAndPump(
      <BlocProvider<StateStreamableSource<Object?>>>[
        BlocProvider<LocationBloc>(create: (_) => locationBloc),
        BlocProvider<ConnectivityBloc>(create: (_) => connectivityBloc)
      ], widget);

      expect(
          find.ancestor(
              // ancestor of IDHome
              of: find.byType(IDHome),
              // descendant of MultiBlocProvider
              matching: find.descendant(
                  of: find.byType(MainAppScreen),
                  matching: find.byType(MediaQuery))),
          findsOneWidget);
    });

    testWidgets(
        'given platform text scale factor is 2.5, when open MainPage, then textScaleFactor is max at 1.25',
        (WidgetTester widgetTester) async {
      final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
      testBinding.window.platformDispatcher.textScaleFactorTestValue = 2.5;

      const MainAppScreen widget = MainAppScreen();

      await widgetTester.multiBlocWrapAndPump(
          <BlocProvider<StateStreamableSource<Object?>>>[
            BlocProvider<LocationBloc>(create: (_) => locationBloc),
            BlocProvider<ConnectivityBloc>(create: (_) => connectivityBloc)
          ], widget);

      final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
          // ancestor of IDHome
          of: find.byType(IDHome),
          // descendant of MainPage
          matching: find.descendant(
              of: find.byType(MainAppScreen),
              matching: find.byType(MediaQuery))));
      expect(mediaQuery.data.textScaleFactor, 1.25);
    });

    testWidgets(
        'given platform text scale factor is 0.5, when open MainPage, then textScaleFactor is min at 0.8',
        (WidgetTester widgetTester) async {
      final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
      testBinding.window.platformDispatcher.textScaleFactorTestValue = 0.5;

      const MainAppScreen widget = MainAppScreen();

      await widgetTester.multiBlocWrapAndPump(
          <BlocProvider<StateStreamableSource<Object?>>>[
            BlocProvider<LocationBloc>(create: (_) => locationBloc),
            BlocProvider<ConnectivityBloc>(create: (_) => connectivityBloc)
          ], widget);

      final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
          // ancestor of IDHome
          of: find.byType(IDHome),
          // descendant of MainPage
          matching: find.descendant(
              of: find.byType(MainAppScreen),
              matching: find.byType(MediaQuery))));

      expect(mediaQuery.data.textScaleFactor, 0.8);
    });

    testWidgets(
        'given platform text scale factor is 1.1, when open MainPage, then textScaleFactor is set at 1.1',
        (WidgetTester widgetTester) async {
      final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
      testBinding.window.platformDispatcher.textScaleFactorTestValue = 1.1;

      const MainAppScreen widget = MainAppScreen();

      await widgetTester.multiBlocWrapAndPump(
          <BlocProvider<StateStreamableSource<Object?>>>[
            BlocProvider<LocationBloc>(create: (_) => locationBloc),
            BlocProvider<ConnectivityBloc>(create: (_) => connectivityBloc)
          ], widget);

      final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
          // ancestor of IDHome
          of: find.byType(IDHome),
          // descendant of MainPage
          matching: find.descendant(
              of: find.byType(MainAppScreen),
              matching: find.byType(MediaQuery))));

      expect(mediaQuery.data.textScaleFactor, 1.1);
    });
  });
}
