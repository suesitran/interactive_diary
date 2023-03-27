import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_diary/service_locator/service_locator.dart';
import 'package:nartus_authentication/nartus_authentication.dart';

part 'google_signup_state.dart';

class GoogleSignupBloc extends Cubit<GoogleSignupState> {
  final AuthenticationService _authenticationService;
  GoogleSignupBloc()
      : _authenticationService =
            ServiceLocator.instance<AuthenticationService>(),
        super(GoogleSignupInitialState());

  Future<dynamic> signUpGoogle() async {
    emit(GoogleSigningUpState());
    try {
      final UserDetail user = await _authenticationService.signinGoogle();
      emit(GoogleSignupSucceedState(user));
    } on AuthenticateFailedException catch (e) {
      if (e.isUserCanceled) {
        emit(GoogleSignupInitialState());
      } else {
        emit(GoogleSignupFailedState(e.error));
      }
    } catch (e) {
      emit(GoogleSignupFailedState(
          'Something wrong happened. Please try again later'));
    }
  }
}
