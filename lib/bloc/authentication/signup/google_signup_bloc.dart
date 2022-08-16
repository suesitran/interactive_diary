import 'package:flutter_bloc/flutter_bloc.dart';

part 'google_signup_event.dart';
part 'google_signup_state.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  GoogleSignupBloc() : super(GoogleSignupInitial()) {
    on<GoogleSignupEvent>((GoogleSignupEvent event, Emitter<GoogleSignupState> emit) {
      // TODO: implement event handler
    });
  }
}
