import 'package:get_it/get_it.dart';
import 'package:nartus_authentication/nartus_authentication.dart';
import 'package:nartus_connectivity/nartus_connectivity.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:nartus_media/nartus_media.dart';
import 'package:nartus_remote_config/remote_config_manager.dart';
import 'package:nartus_storage/nartus_storage.dart';
import 'package:nartus_app_settings/nartus_app_settings.dart';

class ServiceLocator {
  static GetIt get instance => GetIt.instance;

  static Future<void> init() async {
    if (!instance.isRegistered<RemoteConfigManager>()) {
      final RemoteConfigManager remoteConfigManager = RemoteConfigManager();
      await remoteConfigManager.init();

      instance.registerSingleton(remoteConfigManager);
    }

    if (!instance.isRegistered<LocationService>()) {
      instance.registerSingleton(LocationService());
    }

    if (!instance.isRegistered<ConnectivityService>()) {
      instance
          .registerSingleton(ConnectivityService(ImplType.connectivityPlus));
    }

    if (!instance.isRegistered<AuthenticationService>()) {
      instance.registerSingleton(AuthenticationService());
    }

    if (!instance.isRegistered<StorageService>()) {
      // TODO check authentication to choose correct storage service
      instance.registerSingleton(StorageService(StorageType.local));
    }

    if (!instance.isRegistered<GeocoderService>()) {
      instance.registerSingleton(GeocoderService());
    }

    if (!instance.isRegistered<AppSettings>()) {
      instance.registerSingleton(AppSettings.newInstance());
    }

    if (!instance.isRegistered<NartusMediaService>()) {
      instance.registerSingleton(NartusMediaService());
    }
  }
}
