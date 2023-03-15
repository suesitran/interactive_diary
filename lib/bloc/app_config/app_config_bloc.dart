import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

part 'app_config_event.dart';
part 'app_config_state.dart';

class AppConfigBloc extends Bloc<AppConfigEvent, AppConfigState> {
  AppConfigBloc()
      : super(AppConfigInitial()) {
    on<AppRequestInitialise>(_initialise);
  }

  void _initialise(AppConfigEvent event, Emitter<AppConfigState> emit) async {
    // init Date formatting
    initializeDateFormatting();

    // inform UI
    emit(AppConfigInitialised());
  }
}
