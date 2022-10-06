import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:nartus_ui_package/nartus_ui.dart';
import 'dart:ui' as ui;

part 'location_event.dart';
part 'location_state.dart';

final LocationDetails _defaultLocation =
    LocationDetails(10.7840007, 106.7034988);
const String _dateFormat = 'dd-MMM-yyyy';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;
  GlobalKey key = GlobalKey();

  LocationBloc({LocationService? locationService})
      : _locationService = locationService ?? LocationService(),
        super(LocationInitial(PermissionStatusDiary.denied)) {
    on<RequestCurrentLocationEvent>(
        (RequestCurrentLocationEvent event, Emitter<LocationState> emit) async {
      await _requestCurrentLocation(event, emit);
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
      await _requestCurrentLocationAppSetting(emit);
    });
  }

  Future<Uint8List?> _capturePng(GlobalKey iconKey) async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          iconKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData?.buffer.asUint8List();
      print(pngBytes);
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _requestCurrentLocation(
      RequestCurrentLocationEvent event, Emitter<LocationState> emit) async {
    try {
      // key = event.key;
      final LocationDetails data = await _locationService.getCurrentLocation();
      final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());
      final byteData = await _capturePng(key);
      final icon = BitmapDescriptor.fromBytes(byteData!);
      emit(LocationReadyState(data, dateDisplay, icon));
      // emit(LocationReadyState(data, dateDisplay));
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

  Future<void> _requestCurrentLocationAppSetting(
      Emitter<LocationState> emit) async {
    try {
      final LocationDetails data = await _locationService.getCurrentLocation();
      final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());
      final icon = BitmapDescriptor.defaultMarker;
      emit(LocationReadyState(data, dateDisplay, icon));
      // emit(LocationReadyState(
      //   data,
      //   dateDisplay,
      // ));
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
      // RequestCurrentLocationEvent event1 = RequestCurrentLocationEvent(key);
      // await _requestCurrentLocation(event1, emit);
    } else if (status == PermissionStatusDiary.denied) {
      emit(LocationPermissionDeniedState());
    } else if (status == PermissionStatusDiary.deniedForever) {
      emit(LocationPermissionDeniedForeverState());
    }
  }

  Future<void> _requestDefaultLocation(Emitter<LocationState> emit) async {
    final String dateDisplay = DateFormat(_dateFormat).format(DateTime.now());
    // final icon = await BitmapDescriptor.fromAssetImage(
    // ImageConfiguration(size: Size(24, 24)), 'assets/images/ic_marker.png');
    final byteData = await _capturePng(key);
    final icon = BitmapDescriptor.fromBytes(byteData!);
    emit(LocationReadyState(_defaultLocation, dateDisplay, icon));
    // emit(LocationReadyState(_defaultLocation, dateDisplay));
  }

  Future<void> _openAppSettings(Emitter<LocationState> emit) async {
    emit(AwaitLocationPermissionFromAppSettingState());

    await _locationService.requestOpenAppSettings();
  }
}
