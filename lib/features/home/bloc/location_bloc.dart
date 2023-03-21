import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:intl/intl.dart';
import 'package:nartus_geocoder/nartus_geocoder.dart' as gc;
import 'package:nartus_geocoder/nartus_geocoder.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_state.dart';

const LatLng _defaultLocation =
    LatLng(10.7725, 106.6980); //location nhà thờ đức bà
const String _dateFormat = 'dd-MMM-yyyy';

class LocationBloc extends Cubit<LocationState> {
  final LocationService _locationService;
  final GeocoderService _geocoderService;

  LocationBloc()
      : _locationService = ServiceLocator.instance.get<LocationService>(),
        _geocoderService = ServiceLocator.instance.get<GeocoderService>(),
        super(LocationInitial(PermissionStatusDiary.denied));

  Future<void> requestCurrentLocation() async {
    final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());
    try {
      final LocationDetails data = await _locationService.getCurrentLocation();

      String? address;
      String? business;

      try {
        final gc.LocationDetail gcData = await _geocoderService
            .getCurrentPlaceCoding(data.latitude, data.longitude);

        address = gcData.address;
        business = gcData.business;
      } on gc.GetAddressFailedException catch (_) {
      }

      emit(LocationReadyState(
          LatLng(data.latitude, data.longitude), dateDisplay, address, business));

    } on LocationServiceDisableException catch (_) {
      emit(LocationServiceDisableState());
    } on LocationPermissionDeniedException catch (_) {
      emit(LocationPermissionDeniedState());
    } on LocationPermissionDeniedForeverException catch (_) {
      emit(LocationPermissionDeniedForeverState());
    } on Exception catch (_) {
      emit(UnknownLocationErrorState());
    }
  }

  Future<void> showDialogRequestPermissionEvent() async {
    PermissionStatusDiary status = await _locationService.requestPermission();

    if (status == PermissionStatusDiary.granted) {
      await requestCurrentLocation();
    } else if (status == PermissionStatusDiary.denied) {
      emit(LocationPermissionDeniedState());
    } else if (status == PermissionStatusDiary.deniedForever) {
      emit(LocationPermissionDeniedForeverState());
    }
  }

  Future<void> requestDefaultLocation() async {
    final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());

    String? address;
    String? business;
    try {
      final gc.LocationDetail gcData = await _geocoderService
          .getCurrentPlaceCoding(_defaultLocation.latitude, _defaultLocation.longitude);

      address = gcData.address;
      business = gcData.business;
    } on gc.GetAddressFailedException catch (_) {
    }

    emit(LocationReadyState(_defaultLocation, dateDisplay, address, business));
  }

  Future<void> openAppSettings() async {
    emit(AwaitLocationPermissionFromAppSettingState());

    await _locationService.requestOpenAppSettings();
  }

  Future<void> openLocationServiceSetting() async {
    emit(AwaitLocationServiceSettingState());

    await _locationService.requestService();
  }

  Future<void> onReturnFromSettings() => requestCurrentLocation();
}
