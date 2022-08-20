import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

part 'google_signup_event.dart';
part 'google_signup_state.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final AuthenticationService _authenticationService;
  GoogleSignupBloc({AuthenticationService? authenticationService})
      : _authenticationService =
            authenticationService ?? AuthenticationService(),
        super(GoogleSignupInitial()) {
    on<SignUpByGoogleEvent>(
        (GoogleSignupEvent event, Emitter<GoogleSignupState> emit) async {
      await _signUpGoogle(emit);
    });
  }

  Future<dynamic> _signUpGoogle(Emitter<GoogleSignupState> emit) async {
    emit(GoogleSigningUp());
    try {
      final AUser user = await _authenticationService.signinGoogle();
      emit(GoogleSignupSucceed(user));
    } on AuthenticateFailedException catch (e) {
      if (!e.isUserCanceled) {
        emit(GoogleSignupFailed(e.error));
      }
    }
  }
}
