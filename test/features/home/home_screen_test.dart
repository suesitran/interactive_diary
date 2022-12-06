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
import 'package:nartus_ui_package/nartus_ui.dart';

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

  group('Test location device permission request', () {

    testWidgets('given initial location state, then bottom sheet suggesting will not be shown', (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
      Stream<LocationState>.value(LocationInitial(PermissionStatusDiary.granted)));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationInitial(PermissionStatusDiary.granted));

      await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
          infiniteAnimationWidget: true);

      expect(find.byType(NartusBottomSheet), findsNothing);

    });

    testWidgets('given location permission was denied, '
      'then show bottom sheet suggesting enable location on device',
      (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
      Stream<LocationState>.value(LocationPermissionDeniedState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedState());

      await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
          infiniteAnimationWidget: true);

      expect(find.text('Turn on your location'), findsOneWidget);
      expect(find.text('Inner ME needs permission to access your location. '
          'Please go to Settings > Privacy > Location and enable.'), findsOneWidget);
      expect(find.text('Go to Settings'), findsOneWidget);
      expect(find.text('Continue with default location'), findsOneWidget);

    });

    testWidgets('given location permission was denied forever, '
      'then show bottom sheet suggesting enable location on device',
          (WidgetTester widgetTester) async {
        const IDHome widget = IDHome();

        when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
        when(mockLocationBloc.state)
            .thenAnswer((_) => LocationPermissionDeniedForeverState());

        await widgetTester.blocWrapAndPump(mockLocationBloc, widget,
            infiniteAnimationWidget: true);

        expect(find.text('Turn on your location'), findsOneWidget);
        expect(find.text('Inner ME needs permission to access your location. '
            'Please go to Settings > Privacy > Location and enable.'), findsOneWidget);
        expect(find.text('Go to Settings'), findsOneWidget);
        expect(find.text('Continue with default location'), findsOneWidget);
      }
    );
  });

}
