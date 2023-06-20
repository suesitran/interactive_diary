import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_state.dart';

const LatLng _defaultLocation =
    LatLng(10.7725, 106.6980); //location nhà thờ đức bà

class LocationBloc extends Cubit<LocationState> {
  final LocationService _locationService;

  LocationBloc()
      : _locationService = ServiceLocator.instance.get<LocationService>(),
        super(LocationInitial(PermissionStatusDiary.denied));

  bool useDefaultLocation = false;

  Future<void> requestCurrentLocation() async {
    emit(LocationUpdateStart());
    try {
      final LocationDetails data = await _locationService.getCurrentLocation();

      emit(LocationReadyState(
          currentLocation: LatLng(data.latitude, data.longitude)));
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
    emit(LocationUpdateStart());
    useDefaultLocation = true;
    emit(LocationReadyState(currentLocation: _defaultLocation));
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

  Future<void> requestUpdateLocation() {
    if (useDefaultLocation) {
      return requestDefaultLocation();
    } else {
      return requestCurrentLocation();
    }
  }
}
