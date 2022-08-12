import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nartus_location/nartus_location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc({LocationService? locationService})
      : _locationService = locationService ?? LocationService(),
        super(LocationInitial()) {
    on<RequestCurrentLocationEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _requestCurrentLocation(emit);
    });
  }

  Future<void> _requestCurrentLocation(Emitter<LocationState> emit) async {
    try {
      LocationDetails data = await _locationService.getCurrentLocation();

      emit(LocationReadyState(data));

    } on LocationServiceDisableException catch (_) {
      emit(LocationServiceDisableState());
    } on LocationPermissionNotGrantedException catch (_) {
      emit(LocationPermissionNotGrantedState());
    } on Exception catch (e) {
      emit(UnknownLocationErrorState());
    }
  }
}
