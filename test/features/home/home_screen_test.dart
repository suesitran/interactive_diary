import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';

import '../../widget_tester_extension.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks(<Type>[LocationBloc])
void main() {
  final LocationBloc mockLocationBloc = MockLocationBloc();

  testWidgets('When screen is loaded, then check if UI is in a Scaffold',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022')));
    when(mockLocationBloc.state).thenAnswer(
        (_) => LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022'));

    await widgetTester.blocWrapAndPump<LocationBloc>(mockLocationBloc, widget);

    expect(
        find.ancestor(
            of: find.ancestor(
                of: find.byType(GoogleMap),
                matching:
                    find.byType(BlocBuilder<LocationBloc, LocationState>)),
            matching: find.byType(Scaffold)),
        findsAtLeastNWidgets(1));
  });

  testWidgets(
      'When State is LocationReadyState, then GoogleMapView is presented',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    final LocationReadyState state =
        LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022');

    when(mockLocationBloc.stream)
        .thenAnswer((_) => Stream<LocationState>.value(state));
    when(mockLocationBloc.state).thenAnswer((_) => state);

    await widgetTester.blocWrapAndPump<LocationBloc>(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    expect(find.byType(GoogleMapView), findsOneWidget);
  });

  testWidgets(
      'When state is LocationInitial, then CircularProgressIndicator is presented',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationInitial(PermissionStatusDiary.denied)));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationInitial(PermissionStatusDiary.denied));

    await widgetTester.blocWrapAndPump<LocationBloc>(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'When state is LocationPermissionDeniedState, then show Permission explanation dialog',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    expect(find.text('Location Permission not granted'), findsOneWidget);
    expect(
        find.text(
            'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog'),
        findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets(
      'When state is LocationPermissionDeniedForeverState, then show permission explanation dialog',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    expect(find.text('Location Permission not granted'), findsOneWidget);
    expect(
        find.text(
            'Location Permission is needed to use this app. Please Allow Interactive Diary to access location in the next dialog'),
        findsOneWidget);
    expect(find.text('Open Settings'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets(
      'given location permission explanation dialog is visible, when tap on Allow button, then request to show location permission request',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    await widgetTester.tap(find.text('Allow'));

    verify(mockLocationBloc.add(ShowDialogRequestPermissionEvent())).called(1);
  });

  testWidgets(
      'given location permission explanation dialog is visible, when tap on Continue, then request default location',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    await widgetTester.tap(find.text('Continue'));

    verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
  });

  testWidgets(
      'given location explanation dialog when denied forever is visible, when tap on Open Settings, then go to App Settings',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    await widgetTester.tap(find.text('Open Settings'));

    verify(mockLocationBloc.add(OpenAppSettingsEvent()));
  });

  testWidgets(
      'given location explanation dialog when denied forever is visible, when tap on Continue, then request default location',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
        infiniteAnimationWidget: true);

    await widgetTester.tap(find.text('Continue'));

    verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
  });
}
