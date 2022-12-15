import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/bloc/location/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks(<Type>[LocationBloc, ConnectivityBloc])
void main() {
  final MockLocationBloc mockLocationBloc = MockLocationBloc();
  final MockConnectivityBloc mockConnectivityBloc = MockConnectivityBloc();

  setUpAll(() {
    when(mockConnectivityBloc.stream)
        .thenAnswer((_) => Stream<ConnectivityState>.value(ConnectedState()));
    when(mockConnectivityBloc.state).thenAnswer((_) => ConnectedState());
  });

  testWidgets('When screen is loaded, then check if UI is in a Scaffold',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022')));
    when(mockLocationBloc.state).thenAnswer(
        (_) => LocationReadyState(const LatLng(0.0, 0.0), '17-07-2022'));

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc)
            ],
            widget));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc)
            ],
            widget));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));

    expect(find.text('Location Permission not granted'), findsOneWidget);
    expect(
        find.text(
            'Location Permission is needed to use this app. Please allow Inner ME to access location in the next dialog'),
        findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);
    expect(find.text('Continue with default location'), findsOneWidget);
  });

  testWidgets(
      'When state is LocationPermissionDeniedForeverState, then show permission explanation dialog',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));

    expect(find.text('Turn on your location'), findsOneWidget);
    expect(
        find.text(
            'Inner ME needs permission to access your location. Please go to Settings > Privacy > Location and enable.'),
        findsOneWidget);
    expect(find.text('Go to Settings'), findsOneWidget);
    expect(find.text('Continue with default location'), findsOneWidget);
  });

  testWidgets(
      'given location permission explanation dialog is visible, when tap on Allow button, then request to show location permission request',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Continue with default location'));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Go to Settings'));

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

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(<
            BlocProvider<StateStreamableSource<Object?>>>[
          BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc)
        ], widget, infiniteAnimationWidget: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Continue with default location'));

    verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
  });

  testWidgets(
      'when state is LocationServiceDisableState, then show bottom sheet popup',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationServiceDisableState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationServiceDisableState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<ConnectivityBloc>(
                create: (_) => mockConnectivityBloc,
              ),
              BlocProvider<LocationBloc>(
                create: (_) => mockLocationBloc,
              )
            ],
            widget,
            infiniteAnimationWidget: true));

    expect(find.byType(NartusBottomSheet), findsOneWidget);
    expect(find.text('Turn on your location'), findsOneWidget);
    expect(
        find.text(
            'Inner ME needs permission to access your location. Please go to Settings > Privacy > Location and enable.'),
        findsOneWidget);

    expect(find.text('Go to Settings'), findsOneWidget);
    expect(find.text('Continue with default location'), findsOneWidget);
  });

  testWidgets(
      'when bottom sheet popup is visible because of location service disable, tap out to dismiss will not dismiss popup',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationServiceDisableState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationServiceDisableState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<ConnectivityBloc>(
                create: (_) => mockConnectivityBloc,
              ),
              BlocProvider<LocationBloc>(
                create: (_) => mockLocationBloc,
              )
            ],
            widget,
            infiniteAnimationWidget: true));

    expect(find.byType(NartusBottomSheet), findsOneWidget);

    // tap out side popup
    await widgetTester.tapAt(Offset.zero);
    await widgetTester.pump();

    expect(find.byType(NartusBottomSheet), findsOneWidget);
  });

  testWidgets(
      'when bottom sheet popup is visible because of location service disable, tap on Go to Settings will send event OpenLocationServiceEvent',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationServiceDisableState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationServiceDisableState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<ConnectivityBloc>(
                create: (_) => mockConnectivityBloc,
              ),
              BlocProvider<LocationBloc>(
                create: (_) => mockLocationBloc,
              )
            ],
            widget,
            infiniteAnimationWidget: true));
    // wait for animation to finish
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.ancestor(
        of: find.text('Go to Settings'), matching: find.byType(NartusButton)));

    verify(mockLocationBloc.add(OpenLocationServiceEvent()));
  });

  testWidgets(
      'when bottom sheet popup is visible because of location service disable, tap on Continue with default location will send event RequestDefaultLocationEvent',
      (WidgetTester widgetTester) async {
    const IDHome widget = IDHome();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationServiceDisableState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationServiceDisableState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<ConnectivityBloc>(
                create: (_) => mockConnectivityBloc,
              ),
              BlocProvider<LocationBloc>(
                create: (_) => mockLocationBloc,
              )
            ],
            widget,
            infiniteAnimationWidget: true));

    // wait for animation to finish
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.ancestor(
        of: find.text('Continue with default location'),
        matching: find.byType(NartusButton)));

    verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
  });

  group('Test location device permission request', () {
    testWidgets(
        'given initial location state, '
        'then bottom sheet suggesting will not be shown',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
          Stream<LocationState>.value(
              LocationInitial(PermissionStatusDiary.granted)));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationInitial(PermissionStatusDiary.granted));

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      expect(find.byType(NartusBottomSheet), findsNothing);
    });

    testWidgets(
        'given location permission was denied, '
        'then show bottom sheet suggesting enable location on device',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer(
          (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      expect(find.text('Location Permission not granted'), findsOneWidget);
      expect(
          find.text('Location Permission is needed to use this app. '
              'Please allow Inner ME to access location in the next dialog'),
          findsOneWidget);
      expect(find.text('Allow'), findsOneWidget);
      expect(find.text('Continue with default location'), findsOneWidget);
    });

    testWidgets(
        'given location permission was denied forever, '
        'then show bottom sheet suggesting enable location on device',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
          Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedForeverState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      expect(find.text('Turn on your location'), findsOneWidget);
      expect(
          find.text('Inner ME needs permission to access your location. '
              'Please go to Settings > Privacy > Location and enable.'),
          findsOneWidget);
      expect(find.text('Go to Settings'), findsOneWidget);
      expect(find.text('Continue with default location'), findsOneWidget);
    });

    testWidgets(
        'given location permission explanation bottom sheet is visible, '
        'when tap on Allow button, '
        'then request to show location permission request',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer(
          (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Allow'));

      verify(mockLocationBloc.add(ShowDialogRequestPermissionEvent()))
          .called(1);
    });

    testWidgets(
        'given location permission explanation bottom sheet is visible, '
        'when tap outside of bottom sheet, '
        'then bottom sheet will not be closed',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer(
          (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tapAt(const Offset(600, 946));

      expect(find.text('Location Permission not granted'), findsOneWidget);
      expect(
          find.text(
              'Location Permission is needed to use this app. Please allow Inner ME to access location in the next dialog'),
          findsOneWidget);
      expect(find.text('Allow'), findsOneWidget);
      expect(find.text('Continue with default location'), findsOneWidget);
    });

    testWidgets(
        'given location permission explanation bottom sheet is visible, '
        'when tap on Continue with default location, '
        'then bottom sheet will be closed', (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer(
          (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Continue with default location'));

      verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
    });

    testWidgets(
        'given location explanation bottom sheet when denied forever is visible, '
        'when tap on Open Settings, '
        'then go to App Settings', (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
          Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedForeverState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Go to Settings'));

      verify(mockLocationBloc.add(OpenAppSettingsEvent()));
    });

    testWidgets(
        'given location explanation dialog when denied forever is visible, when tap on Continue with default location, then bottom sheet will be closed',
        (WidgetTester widgetTester) async {
      const IDHome widget = IDHome();

      when(mockLocationBloc.stream).thenAnswer((_) =>
          Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => LocationPermissionDeniedForeverState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                )
              ],
              widget,
              infiniteAnimationWidget: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Continue with default location'));

      verify(mockLocationBloc.add(RequestDefaultLocationEvent()));
    });
  });
}
