import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:mockito/annotations.dart';
import 'package:nartus_authentication/nartus_authentication.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';
import 'package:nartus_storage/nartus_storage.dart';

import '../mock_firebase.dart';
import 'service_locator_test.mocks.dart';

@GenerateMocks([
  RemoteConfigManager,
  AuthenticationService,
  LocationService,
  ConnectivityService,
  StorageService,
  GeocoderService
])
void main() {
  setupFirebaseAuthMocks();

  test('test ServiceLocator', () async {
    final MockRemoteConfigManager remoteConfigManager =
        MockRemoteConfigManager();
    final MockAuthenticationService authenticationService =
        MockAuthenticationService();
    final MockLocationService locationService = MockLocationService();
    final MockConnectivityService connectivityService =
        MockConnectivityService();
    final MockStorageService storageService = MockStorageService();
    final MockGeocoderService geocoderService = MockGeocoderService();

    ServiceLocator.instance
        .registerSingleton<RemoteConfigManager>(remoteConfigManager);
    ServiceLocator.instance
        .registerSingleton<AuthenticationService>(authenticationService);
    ServiceLocator.instance.registerSingleton<LocationService>(locationService);
    ServiceLocator.instance
        .registerSingleton<ConnectivityService>(connectivityService);
    ServiceLocator.instance.registerSingleton<StorageService>(storageService);
    ServiceLocator.instance.registerSingleton<GeocoderService>(geocoderService);

    await ServiceLocator.init();

    expect(ServiceLocator.instance.isRegistered<LocationService>(), isTrue);
    expect(
        ServiceLocator.instance.isRegistered<AuthenticationService>(), isTrue);
    expect(ServiceLocator.instance.isRegistered<LocationService>(), isTrue);
    expect(ServiceLocator.instance.isRegistered<ConnectivityService>(), isTrue);
    expect(ServiceLocator.instance.isRegistered<StorageService>(), isTrue);
    expect(ServiceLocator.instance.isRegistered<GeocoderService>(), isTrue);
  });
}
