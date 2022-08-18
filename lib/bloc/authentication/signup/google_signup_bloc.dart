import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

part 'google_signup_event.dart';
part 'google_signup_state.dart';

class GoogleSignupBloc extends Bloc<GoogleSignupEvent, GoogleSignupState> {
  final AuthenticationService _authenticationService;
  GoogleSignupBloc({AuthenticationService? authenticationService}) :
    _authenticationService = authenticationService ?? AuthenticationService(),
    super(GoogleSignupInitial()) {
    on<SignUpByGoogle>((GoogleSignupEvent event, Emitter<GoogleSignupState> emit) async {
      await _signUpGoogle(emit);
    });
  }

  Future<dynamic> _signUpGoogle(Emitter<GoogleSignupState> emit) async {
    try {
      final AUser? user = await _authenticationService.signinGoogle();
      if (user != null) {
        emit(GoogleSignupSucceed(user));
      }
      emit(GoogleSignupFailed('No user found'));
    } catch (e) {
      emit(GoogleSignupFailed('No user found'));
    }
  }
}
