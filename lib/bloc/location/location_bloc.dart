import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_event.dart';
part 'location_state.dart';

final LocationDetails _defaultLocation = LocationDetails(10.7840007, 106.7034988);

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
  }

  Future<void> _requestCurrentLocation(
       Emitter<LocationState> emit) async {
      try {
        final LocationDetails data =
            await _locationService.getCurrentLocation();
        final String dateDisplay =
            DateFormat('dd-MMM-yyyy').format(DateTime.now());

        emit(LocationReadyState(data, dateDisplay));
      } on LocationServiceDisableException catch (_) {
        emit(LocationServiceDisableState());
      } on LocationPermissionDeniedException catch (_) {
        emit(LocationPermissionDeniedState());
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
      // open app setting
      await _locationService.requestOpenAppSettings();
    }
  }
}
