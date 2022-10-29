import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_tester_extension.dart';
import 'main_test.mocks.dart';

@GenerateMocks(<Type>[LocationBloc])
void main() {
  final LocationBloc locationBloc = MockLocationBloc();

  setUpAll(() {
    when(locationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022')));
    when(locationBloc.state).thenAnswer(
        (_) => LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022'));
  });

  testWidgets('given when MainPage is shown, then MediaQuery widget is used',
      (WidgetTester widgetTester) async {
    const MainPage widget = MainPage();

    await widgetTester.blocWrapAndPump<LocationBloc>(locationBloc, widget);

    expect(
        find.ancestor(
          // ancestor of IDHome
            of: find.byType(IDHome),
            // descendant of MultiBlocProvider
            matching: find.descendant(
                of: find.byType(MainPage),
                matching: find.byType(MediaQuery))),
        findsOneWidget);
  });

  testWidgets('given platform text scale factor is 2.5, when open MainPage, then textScaleFactor is max at 1.25', (widgetTester) async {
    final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
    testBinding.window.platformDispatcher.textScaleFactorTestValue = 2.5;

    const MainPage widget = MainPage();
    
    await widgetTester.blocWrapAndPump<LocationBloc>(locationBloc, widget);
    
    final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
      // ancestor of IDHome
        of: find.byType(IDHome),
        // descendant of MainPage
        matching: find.descendant(
            of: find.byType(MainPage),
            matching: find.byType(MediaQuery))));
    
    expect(mediaQuery.data.textScaleFactor, 1.25);
  });

  testWidgets('given platform text scale factor is 0.5, when open MainPage, then textScaleFactor is min at 0.8', (widgetTester) async {
    final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
    testBinding.window.platformDispatcher.textScaleFactorTestValue = 0.5;

    const MainPage widget = MainPage();

    await widgetTester.blocWrapAndPump<LocationBloc>(locationBloc, widget);

    final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
      // ancestor of IDHome
        of: find.byType(IDHome),
        // descendant of MainPage
        matching: find.descendant(
            of: find.byType(MainPage),
            matching: find.byType(MediaQuery))));

    expect(mediaQuery.data.textScaleFactor, 0.8);
  });

  testWidgets('given platform text scale factor is 1.1, when open MainPage, then textScaleFactor is set at 1.1', (widgetTester) async {
    final TestWidgetsFlutterBinding testBinding = widgetTester.binding;
    testBinding.window.platformDispatcher.textScaleFactorTestValue = 1.1;

    const MainPage widget = MainPage();

    await widgetTester.blocWrapAndPump<LocationBloc>(locationBloc, widget);

    final MediaQuery mediaQuery = widgetTester.widget(find.ancestor(
      // ancestor of IDHome
        of: find.byType(IDHome),
        // descendant of MainPage
        matching: find.descendant(
            of: find.byType(MainPage),
            matching: find.byType(MediaQuery))));

    expect(mediaQuery.data.textScaleFactor, 1.1);
  });
}
