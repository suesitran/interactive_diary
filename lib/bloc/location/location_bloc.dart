import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nartus_location/nartus_location.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
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
    on<RequestPermissionLocationEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _requestPermissionLocationEvent(emit);
    });
    on<DefaultLocationServiceEvent>(
        (LocationEvent event, Emitter<LocationState> emit) async {
      await _defaultLocationServiceEvent(emit);
    });
  }

  Future<void> _requestCurrentLocation(Emitter<LocationState> emit) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    //internet connected
    if (isConnected) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool isLoaded = prefs.getBool('isLoadedDialog') ?? false;
      //not Load permission dialog
      if (!isLoaded) {
        try {
          final LocationDetails data =
              await _locationService.getCurrentLocation();
          final String dateDisplay =
              DateFormat('dd-MMM-yyyy').format(DateTime.now());
          emit(LocationReadyState(data, dateDisplay));
        } on LocationServiceDisableException catch (_) {
          emit(LocationServiceDisableState());
        } on LocationPermissionNotGrantedException catch (_) {
          emit(LocationPermissionNotGrantedState());
        } on Exception catch (_) {
          emit(UnknownLocationErrorState());
        }
      }
      //Loaded permission dialog
      else {
        final PermissionStatus permissionGranted =
            await _locationService.permissionStatus();
        final LocationDetails data =
            await _locationService.getCurrentLocation();
        final LocationDetails dataDefault =
            LocationDetails(10.7840007, 106.7034988);
        final String dateDisplay =
            DateFormat('dd-MMM-yyyy').format(DateTime.now());
        switch (permissionGranted) {
          //permission granted
          case PermissionStatus.granted:
            emit(LocationReadyState(data, dateDisplay));
            break;
          //permission denied -  load default location
          case PermissionStatus.denied:
            emit(LocationReadyState(dataDefault, dateDisplay));
            break;
          //permission deniedForever -  load default location
          case PermissionStatus.deniedForever:
            emit(LocationReadyState(dataDefault, dateDisplay));
            break;
          default:
        }
      }
    }
    //internet not connected
    else {
      emit(InternetDisconectedState());
    }
  }

  Future<void> _requestPermissionLocationEvent(
      Emitter<LocationState> emit) async {
    final PermissionStatus permissionGranted =
        await _locationService.requestPermission();
    //set loaded dialog
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoadedDialog', true);
    switch (permissionGranted) {
      //permission granted
      case PermissionStatus.granted:
        final LocationDetails data =
            await _locationService.getCurrentLocation();
        final String dateDisplay =
            DateFormat('dd-MMM-yyyy').format(DateTime.now());
        emit(LocationReadyState(data, dateDisplay));
        break;
      //permission denied
      case PermissionStatus.denied:
        emit(LocationPermissionDeniedState());
        break;
      //permission deniedForever
      case PermissionStatus.deniedForever:
        emit(LocationPermissionDeniedState());
        break;
      default:
    }
  }

  Future<void> _defaultLocationServiceEvent(Emitter<LocationState> emit) async {
    //default location when press continue button in permission dialog
    final LocationDetails dataDefault =
        LocationDetails(10.7840007, 106.7034988);
    final String dateDisplay = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    emit(LocationReadyState(dataDefault, dateDisplay));
  }
}
