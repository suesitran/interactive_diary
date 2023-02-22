import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_event.dart';
part 'location_state.dart';

const LatLng _defaultLocation =
    LatLng(10.7725, 106.6980); //location nhà thờ đức bà
const String _dateFormat = 'dd-MMM-yyyy';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc({LocationService? locationService})
      : _locationService = locationService ?? LocationService(),
        super(LocationInitial(PermissionStatusDiary.denied)) {
    on<RequestCurrentLocationEvent>(
        (RequestCurrentLocationEvent event, Emitter<LocationState> emit) async {
      await _requestCurrentLocation(emit);
    });

    on<ShowDialogRequestPermissionEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _showDialogRequestPermissionEvent(emit);
    });

    on<RequestDefaultLocationEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _requestDefaultLocation(emit);
    });

    on<OpenAppSettingsEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _openAppSettings(emit);
    });

    on<ReturnedFromAppSettingsEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _requestCurrentLocation(emit);
    });

    on<OpenLocationServiceEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _openLocationServiceSetting(emit);
    });
  }

  Future<void> _requestCurrentLocation(Emitter<LocationState> emit) async {
    try {
      final LocationDetails data = await _locationService.getCurrentLocation();
      final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());

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

  Future<void> _showDialogRequestPermissionEvent(
      Emitter<LocationState> emit) async {
    PermissionStatusDiary status = await _locationService.requestPermission();

    if (status == PermissionStatusDiary.granted) {
      await _requestCurrentLocation(emit);
    } else if (status == PermissionStatusDiary.denied) {
      emit(LocationPermissionDeniedState());
    } else if (status == PermissionStatusDiary.deniedForever) {
      emit(LocationPermissionDeniedForeverState());
    }
  }

  Future<void> _requestDefaultLocation(Emitter<LocationState> emit) async {
    final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());

    emit(LocationReadyState(_defaultLocation, dateDisplay));
  }

  Future<void> _openAppSettings(Emitter<LocationState> emit) async {
    emit(AwaitLocationPermissionFromAppSettingState());

    await _locationService.requestOpenAppSettings();
  }

  Future<void> _openLocationServiceSetting(Emitter<LocationState> emit) async {
    emit(AwaitLocationServiceSettingState());

    await _locationService.requestService();
  }
}
