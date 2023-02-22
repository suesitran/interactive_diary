import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_state.dart';

const LatLng _defaultLocation =
    LatLng(10.7725, 106.6980); //location nhà thờ đức bà
const String _dateFormat = 'dd-MMM-yyyy';

class LocationBloc extends Cubit<LocationState> {
  final LocationService _locationService;

  LocationBloc({LocationService? locationService})
      : _locationService = locationService ?? LocationService(),
        super(LocationInitial(PermissionStatusDiary.denied));

  Future<void> requestCurrentLocation() async {
    try {
      print('request current location');
      final LocationDetails data = await _locationService.getCurrentLocation();
      final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());

      print('location ready state ${data.latitude}, ${data.longitude}');
      emit(LocationReadyState(
          LatLng(data.latitude, data.longitude), dateDisplay));
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

    emit(LocationReadyState(_defaultLocation, dateDisplay));
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
