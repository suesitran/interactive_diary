import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

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
  }

  Future<void> _requestCurrentLocation(
      RequestCurrentLocationEvent event, Emitter<LocationState> emit) async {
    if (event.status == PermissionStatusDiary.defaultLocation) {
      const double latitude = 10.7840007;
      const double longitude = 106.7034988;
      final LocationDetails dataDefault = LocationDetails(latitude, longitude);
      final String dateDisplay =
          DateFormat('dd-MMM-yyyy').format(DateTime.now());
      emit(LocationReadyState(dataDefault, dateDisplay));
    } else {
      try {
        final LocationDetails data =
            await _locationService.getCurrentLocation();
        final String dateDisplay =
            DateFormat('dd-MMM-yyyy').format(DateTime.now());

        emit(LocationReadyState(data, dateDisplay));
      } on LocationServiceDisableException catch (_) {
        emit(LocationServiceDisableState());
      } on LocationPermissionNotGrantedException catch (_) {
        emit(LocationPermissionNotGrantedState(event.status));
      } on Exception catch (_) {
        emit(UnknownLocationErrorState());
      }
    }
  }

  Future<void> _showDialogRequestPermissionEvent(
      Emitter<LocationState> emit) async {
    final PermissionStatusDiary permission =
        await _locationService.requestPermission();
    debugPrint(permission);
    emit(LocationInitial(permission));
  }
}
