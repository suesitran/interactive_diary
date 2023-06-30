import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/bloc/app_config/app_config_bloc.dart';
import 'package:interactive_diary/bloc/camera_permission/camera_permission_bloc.dart';
import 'package:interactive_diary/bloc/connectivity/connectivity_bloc.dart';
import 'package:interactive_diary/debug/widget_catalog/widget_catalog.dart';
import 'package:interactive_diary/features/home/bloc/address_cubit.dart';
import 'package:interactive_diary/features/home/bloc/load_diary_cubit.dart';
import 'package:interactive_diary/features/home/bloc/location_bloc.dart';
import 'package:interactive_diary/features/home/home_screen.dart';
import 'package:interactive_diary/features/home/widgets/google_map.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nartus_authentication/nartus_authentication.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:nartus_storage/nartus_storage.dart' hide LatLng;
import 'package:nartus_ui_package/nartus_ui.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:nartus_media/nartus_media.dart';

import '../../widget_tester_extension.dart';
import 'home_screen_test.mocks.dart';
import 'package:intl/date_symbol_data_local.dart';

@GenerateMocks(<Type>[
  LocationBloc,
  ConnectivityBloc,
  LocationService,
  AppConfigBloc,
  GeocoderService,
  LoadDiaryCubit,
  StorageService,
  CameraPermissionBloc,
  NartusMediaService,
  AddressCubit,
  AuthenticationService
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  final MockLocationBloc mockLocationBloc = MockLocationBloc();
  final MockConnectivityBloc mockConnectivityBloc = MockConnectivityBloc();
  final MockLocationService locationService = MockLocationService();
  final MockAppConfigBloc appConfigBloc = MockAppConfigBloc();
  final MockGeocoderService geocoderService = MockGeocoderService();
  final MockLoadDiaryCubit loadDiaryCubit = MockLoadDiaryCubit();
  final MockStorageService storageService = MockStorageService();
  final MockCameraPermissionBloc cameraPermissionBloc =
      MockCameraPermissionBloc();
  final MockNartusMediaService mediaService = MockNartusMediaService();
  final MockAddressCubit addressCubit = MockAddressCubit();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() {
    ServiceLocator.instance.registerSingleton<LocationService>(locationService);
    ServiceLocator.instance.registerSingleton<GeocoderService>(geocoderService);
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
    ServiceLocator.instance.registerSingleton<NartusMediaService>(mediaService);
    ServiceLocator.instance
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  setUp(() {
    when(mockConnectivityBloc.stream)
        .thenAnswer((_) => Stream<ConnectivityState>.value(ConnectedState()));
    when(mockConnectivityBloc.state).thenAnswer((_) => ConnectedState());

    when(locationService.getCurrentLocation()).thenAnswer(
        (realInvocation) => Future.value(LocationDetails(0.0, 0.0)));

    when(appConfigBloc.state).thenReturn(AppConfigInitial());
    when(appConfigBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(AppConfigInitial()));

    when(mockLocationBloc.state)
        .thenReturn(LocationInitial(PermissionStatusDiary.granted));
    when(mockLocationBloc.stream).thenAnswer((realInvocation) =>
        Stream.value(LocationInitial(PermissionStatusDiary.granted)));

    when(geocoderService.getCurrentPlaceCoding(any, any)).thenAnswer(
        (realInvocation) => Future.value(LocationDetail(
            address: 'address',
            business: 'business',
            countryCode: 'AU',
            postalCode: '2345')));

    when(loadDiaryCubit.state)
        .thenAnswer((realInvocation) => LoadDiaryInitial());
    when(loadDiaryCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(LoadDiaryInitial()));

    when(cameraPermissionBloc.state)
        .thenAnswer((realInvocation) => CameraPermissionInitial());
    when(cameraPermissionBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(CameraPermissionInitial()));

    when(addressCubit.state).thenReturn(AddressInitial());
    when(addressCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(AddressInitial()));

    when(authenticationService.getCurrentUser())
        .thenThrow(AuthenticationException('not found'));
  });

  tearDown(() {
    reset(mockLocationBloc);
    reset(mockConnectivityBloc);
    reset(locationService);
    reset(appConfigBloc);
    reset(geocoderService);
    reset(loadDiaryCubit);
    reset(storageService);
    reset(cameraPermissionBloc);
    reset(mediaService);
    reset(addressCubit);
  });

  testWidgets('When screen is loaded, then check if UI is in a Scaffold',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationReadyState(currentLocation: const LatLng(0.0, 0.0))));
    when(mockLocationBloc.state).thenAnswer(
        (_) => LocationReadyState(currentLocation: const LatLng(0.0, 0.0)));

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<LocationBloc>(create: (_) {
            return mockLocationBloc;
          }),
          BlocProvider<ConnectivityBloc>(create: (_) => mockConnectivityBloc),
          BlocProvider<AppConfigBloc>(
            create: (_) => appConfigBloc,
          ),
          BlocProvider<LoadDiaryCubit>(
            create: (_) => loadDiaryCubit,
          ),
          BlocProvider<CameraPermissionBloc>(
            create: (_) => cameraPermissionBloc,
          ),
          BlocProvider<AddressCubit>(
            create: (context) => addressCubit,
          )
        ], widget, infiniteAnimationWidget: true, useRouter: true));

    expect(
        find.ancestor(
            of: find.ancestor(
                of: find.byType(GoogleMap),
                matching:
                    find.byType(BlocBuilder<LocationBloc, LocationState>)),
            matching: find.byType(Scaffold)),
        findsAtLeastNWidgets(1));
  });

  // comment out because of issue https://github.com/flutter/flutter/issues/120556
  testWidgets(
      'When State is LocationReadyState, then GoogleMapView is presented',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    final LocationReadyState state =
        LocationReadyState(currentLocation: const LatLng(0.0, 0.0));

    when(mockLocationBloc.stream)
        .thenAnswer((_) => Stream<LocationState>.value(state));
    when(mockLocationBloc.state).thenAnswer((_) => state);

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (_) => loadDiaryCubit,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              )
            ],
            widget,
            useRouter: true));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GoogleMapView), findsOneWidget);
  });

  testWidgets('When state is LocationInitial, then GoogleMap is presented',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer((_) => Stream<LocationState>.value(
        LocationInitial(PermissionStatusDiary.denied)));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationInitial(PermissionStatusDiary.denied));

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

    expect(find.byType(GoogleMap), findsOneWidget);
  });

  testWidgets(
      'When state is LocationPermissionDeniedState, then show Permission explanation dialog',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

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
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

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
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Allow'));

    verify(mockLocationBloc.showDialogRequestPermissionEvent()).called(1);
  });

  testWidgets(
      'given location permission explanation dialog is visible, when tap on Continue, then request default location',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer(
        (_) => Stream<LocationState>.value(LocationPermissionDeniedState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Continue with default location'));

    verify(mockLocationBloc.requestDefaultLocation()).called(1);
  });

  testWidgets(
      'given location explanation dialog when denied forever is visible, when tap on Open Settings, then go to App Settings',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Go to Settings'));

    verify(mockLocationBloc.openAppSettings()).called(1);
  });

  testWidgets(
      'given location explanation dialog when denied forever is visible, when tap on Continue, then request default location',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

    when(mockLocationBloc.stream).thenAnswer((_) =>
        Stream<LocationState>.value(LocationPermissionDeniedForeverState()));
    when(mockLocationBloc.state)
        .thenAnswer((_) => LocationPermissionDeniedForeverState());

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
            <BlocProvider<StateStreamableSource<Object?>>>[
              BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
              BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));
    // wait for animation to complete
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.text('Continue with default location'));

    verify(mockLocationBloc.requestDefaultLocation()).called(1);
  });

  testWidgets(
      'when state is LocationServiceDisableState, then show bottom sheet popup',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

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
              ),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

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
    const IDHomeBody widget = IDHomeBody();

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
              ),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

    expect(find.byType(NartusBottomSheet), findsOneWidget);

    // tap out side popup
    await widgetTester.tapAt(Offset.zero);
    await widgetTester.pump();

    expect(find.byType(NartusBottomSheet), findsOneWidget);
  });

  testWidgets(
      'when bottom sheet popup is visible because of location service disable, tap on Go to Settings will send event OpenLocationServiceEvent',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

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
              ),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));
    // wait for animation to finish
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.ancestor(
        of: find.text('Go to Settings'), matching: find.byType(NartusButton)));

    verify(mockLocationBloc.openLocationServiceSetting()).called(1);
  });

  testWidgets(
      'when bottom sheet popup is visible because of location service disable, tap on Continue with default location will send event RequestDefaultLocationEvent',
      (WidgetTester widgetTester) async {
    const IDHomeBody widget = IDHomeBody();

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
              ),
              BlocProvider<AppConfigBloc>(
                create: (_) => appConfigBloc,
              ),
              BlocProvider<CameraPermissionBloc>(
                create: (_) => cameraPermissionBloc,
              ),
              BlocProvider<AddressCubit>(
                create: (context) => addressCubit,
              ),
              BlocProvider<LoadDiaryCubit>(
                create: (context) => loadDiaryCubit,
              )
            ],
            widget,
            infiniteAnimationWidget: true,
            useRouter: true));

    // wait for animation to finish
    await widgetTester.pump(const Duration(seconds: 1));

    await widgetTester.tap(find.ancestor(
        of: find.text('Continue with default location'),
        matching: find.byType(NartusButton)));

    verify(mockLocationBloc.requestDefaultLocation()).called(1);
  });

  group('Test location device permission request', () {
    testWidgets(
        'given initial location state, '
        'then bottom sheet suggesting will not be shown',
        (WidgetTester widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      expect(find.byType(NartusBottomSheet), findsNothing);
    });

    testWidgets(
        'given location permission was denied, '
        'then show bottom sheet suggesting enable location on device',
        (WidgetTester widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

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
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

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
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Allow'));

      verify(mockLocationBloc.showDialogRequestPermissionEvent()).called(1);
    });

    testWidgets(
        'given location permission explanation bottom sheet is visible, '
        'when tap outside of bottom sheet, '
        'then bottom sheet will not be closed',
        (WidgetTester widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

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
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Continue with default location'));

      verify(mockLocationBloc.requestDefaultLocation()).called(1);
    });

    testWidgets(
        'given location explanation bottom sheet when denied forever is visible, '
        'when tap on Open Settings, '
        'then go to App Settings', (WidgetTester widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Go to Settings'));

      verify(mockLocationBloc.openAppSettings()).called(1);
    });

    testWidgets(
        'given location explanation dialog when denied forever is visible, '
        'when tap on Continue with default location, then bottom sheet will be closed',
        (WidgetTester widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

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
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      /// pumpAndSettle : only wait for 500ms
      /// Wait for bottom sheet animation to finish
      await widgetTester.pump(const Duration(seconds: 1));

      await widgetTester.tap(find.text('Continue with default location'));

      verify(mockLocationBloc.requestDefaultLocation()).called(1);
    });

    testWidgets(
        'given requesting location permission, when return to screen, then call onReturnFromSettings',
        (widgetTester) async {
      const IDHomeBody widget = IDHomeBody();

      when(mockLocationBloc.stream).thenAnswer((_) =>
          Stream<LocationState>.value(
              AwaitLocationPermissionFromAppSettingState()));
      when(mockLocationBloc.state)
          .thenAnswer((_) => AwaitLocationPermissionFromAppSettingState());

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true));

      WidgetsBinding.instance
          .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      verify(mockLocationBloc.onReturnFromSettings()).called(1);
    });
  });

  // TODO fix this test when improving loading process in google_map
  testWidgets('Verify IDHome has a bloc and content is a IDHomeBody',
      (widgetTester) async {
    const Widget widget = IDHome();

    await widgetTester.multiBlocWrapAndPump([
      // BlocProvider<LocationBloc>(create: (_) => mockLocationBloc),
      BlocProvider<AppConfigBloc>(
        create: (_) => appConfigBloc,
      ),
      BlocProvider<ConnectivityBloc>(
        create: (_) => mockConnectivityBloc,
      ),
    ], widget, infiniteAnimationWidget: true, useRouter: true);

    expect(find.byType(BlocProvider<LocationBloc>), findsOneWidget);
    expect(find.byType(BlocProvider<LoadDiaryCubit>), findsOneWidget);
    expect(find.byType(BlocProvider<CameraPermissionBloc>), findsOneWidget);
    expect(
        find.byType(BlocListener<CameraPermissionBloc, CameraPermissionState>),
        findsOneWidget);
    expect(find.byType(IDHomeBody), findsOneWidget);
  });

  group('test camera permission reaction', () {
    testWidgets(
        'given camera permission granted, when location is available, then navigate to camera screen',
        (widgetTester) async {
      const Widget widget = IDHomeBody();

      when(cameraPermissionBloc.state)
          .thenAnswer((realInvocation) => CameraPermissionGranted());
      when(cameraPermissionBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(CameraPermissionGranted()));

      when(mockLocationBloc.state).thenAnswer((realInvocation) =>
          LocationReadyState(currentLocation: const LatLng(0.0, 0.0)));
      when(mockLocationBloc.stream).thenAnswer((realInvocation) => Stream.value(
          LocationReadyState(currentLocation: const LatLng(0.0, 0.0))));

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true,
              targetRoute: '/addMedia'));
      await widgetTester.pump();

      // expect navigate to /addMedia
      expect(find.text('/addMedia'), findsOneWidget);
    });

    testWidgets(
        'given camera permission granted, when location is not available, then do not navigate to camera screen',
        (widgetTester) async {
      const Widget widget = IDHomeBody();

      when(cameraPermissionBloc.state)
          .thenAnswer((realInvocation) => CameraPermissionGranted());
      when(cameraPermissionBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(CameraPermissionGranted()));

      when(mockLocationBloc.state).thenAnswer(
          (realInvocation) => LocationInitial(PermissionStatusDiary.granted));
      when(mockLocationBloc.stream).thenAnswer((realInvocation) =>
          Stream.value(LocationInitial(PermissionStatusDiary.granted)));

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true,
              targetRoute: '/addMedia'));
      await widgetTester.pump();

      // do not navigate to /addMedia
      expect(find.text('/addMedia'), findsNothing);
      expect(find.byType(IDHomeBody), findsOneWidget);
    });

    testWidgets(
        'given camera permission denied, then request camera permission',
        (widgetTester) async {
      const Widget widget = IDHomeBody();

      when(cameraPermissionBloc.state)
          .thenAnswer((realInvocation) => CameraPermissionDenied());
      when(cameraPermissionBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(CameraPermissionDenied()));

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true,
              targetRoute: '/addMedia'));
      await widgetTester.pump();

      // expect navigate to /addMedia
      verify(cameraPermissionBloc.add(RequestCameraPermissionEvent()))
          .called(1);
    });

    testWidgets('given camera permission denied forever, then do nothing',
        (widgetTester) async {
      const Widget widget = IDHomeBody();

      when(cameraPermissionBloc.state)
          .thenAnswer((realInvocation) => CameraPermissionDeniedForever());
      when(cameraPermissionBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(CameraPermissionDeniedForever()));

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
              <BlocProvider<StateStreamableSource<Object?>>>[
                BlocProvider<ConnectivityBloc>(
                  create: (_) => mockConnectivityBloc,
                ),
                BlocProvider<LocationBloc>(
                  create: (_) => mockLocationBloc,
                ),
                BlocProvider<AppConfigBloc>(
                  create: (_) => appConfigBloc,
                ),
                BlocProvider<CameraPermissionBloc>(
                  create: (_) => cameraPermissionBloc,
                ),
                BlocProvider<AddressCubit>(
                  create: (context) => addressCubit,
                ),
                BlocProvider<LoadDiaryCubit>(
                  create: (context) => loadDiaryCubit,
                )
              ],
              widget,
              infiniteAnimationWidget: true,
              useRouter: true,
              targetRoute: '/addMedia'));
      await widgetTester.pump();

      // expect navigate to /addMedia
      verifyNever(cameraPermissionBloc.add(ValidateCameraPermissionEvent()));
      verifyNever(cameraPermissionBloc.add(RequestCameraPermissionEvent()));
    });
  });

  group(
    'Verify pop when AwaitLocationServiceSettingState',
    () {
      testWidgets(
        'given state is AwaitLocationServiceSettingState,'
        'when AppLifecycleState is resumed,'
        'then pop navigation',
        (widgetTester) async {
          // given
          when(mockLocationBloc.state)
              .thenReturn(AwaitLocationServiceSettingState());
          when(mockLocationBloc.stream).thenAnswer((realInvocation) =>
              Stream.value(AwaitLocationServiceSettingState()));

          const Widget widget = IDHomeBody();

          await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
                <BlocProvider<StateStreamableSource<Object?>>>[
                  BlocProvider<ConnectivityBloc>(
                    create: (_) => mockConnectivityBloc,
                  ),
                  BlocProvider<LocationBloc>(
                    create: (_) => mockLocationBloc,
                  ),
                  BlocProvider<AppConfigBloc>(
                    create: (_) => appConfigBloc,
                  ),
                  BlocProvider<CameraPermissionBloc>(
                    create: (_) => cameraPermissionBloc,
                  ),
                  BlocProvider<AddressCubit>(
                    create: (context) => addressCubit,
                  ),
                  BlocProvider<LoadDiaryCubit>(
                    create: (context) => loadDiaryCubit,
                  )
                ],
                widget,
                infiniteAnimationWidget: true,
                useRouter: true,
              ));

          // when
          widgetTester.binding
              .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
          await widgetTester.pumpAndSettle();

          // then
          expect(find.byType(IDHomeBody), findsNothing);
        },
      );
    },
  );

  group(
    'verify no-internet connection banner',
    () {
      testWidgets(
          'given no internet connection, when launch home screen, then navigate to no connection',
          (widgetTester) async {
        // given
        when(mockConnectivityBloc.state).thenReturn(DisconnectedState());
        when(mockConnectivityBloc.stream)
            .thenAnswer((realInvocation) => Stream.value(DisconnectedState()));

        // when
        const Widget widget = IDHomeBody();
        await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
                <BlocProvider<StateStreamableSource<Object?>>>[
                  BlocProvider<ConnectivityBloc>(
                    create: (_) => mockConnectivityBloc,
                  ),
                  BlocProvider<LocationBloc>(
                    create: (_) => mockLocationBloc,
                  ),
                  BlocProvider<AppConfigBloc>(
                    create: (_) => appConfigBloc,
                  ),
                  BlocProvider<CameraPermissionBloc>(
                    create: (_) => cameraPermissionBloc,
                  ),
                  BlocProvider<AddressCubit>(
                    create: (context) => addressCubit,
                  ),
                  BlocProvider<LoadDiaryCubit>(
                    create: (context) => loadDiaryCubit,
                  )
                ],
                widget,
                infiniteAnimationWidget: true,
                useRouter: true,
                targetRoute: '/noConnection'));
        await widgetTester.pumpAndSettle();

        // then
        expect(find.text('/noConnection'), findsOneWidget);
      });
    },
  );

  group(
    'verify shake action to show widget catalog',
    () {
      testWidgets(
          'given device is shaked, when launch home screen, then navigate to widget catalog',
          (widgetTester) async {
        // given
        when(appConfigBloc.state).thenReturn(ShakeDetected(0));
        when(appConfigBloc.stream)
            .thenAnswer((realInvocation) => Stream.value(ShakeDetected(0)));

        // when
        const Widget widget = IDHomeBody();
        await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
                <BlocProvider<StateStreamableSource<Object?>>>[
                  BlocProvider<ConnectivityBloc>(
                    create: (_) => mockConnectivityBloc,
                  ),
                  BlocProvider<LocationBloc>(
                    create: (_) => mockLocationBloc,
                  ),
                  BlocProvider<AppConfigBloc>(
                    create: (_) => appConfigBloc,
                  ),
                  BlocProvider<CameraPermissionBloc>(
                    create: (_) => cameraPermissionBloc,
                  ),
                  BlocProvider<AddressCubit>(
                    create: (context) => addressCubit,
                  ),
                  BlocProvider<LoadDiaryCubit>(
                    create: (context) => loadDiaryCubit,
                  )
                ],
                widget,
                infiniteAnimationWidget: true,
                useRouter: true,
                targetRoute: '/noConnection'));
        await widgetTester.pumpAndSettle();

        // then
        expect(find.byType(WidgetCatalog), findsOneWidget);
      });
    },
  );
}
