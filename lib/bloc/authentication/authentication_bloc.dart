import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// Authentication bloc contains only the authentication status,
/// whether user currently has login session, or not
/// no signup/sign in implementation is stored here.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<ValidateAuthenticationEvent>((event, emit) {});
  }
}
