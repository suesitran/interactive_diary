part of 'google_signup_bloc.dart';

abstract class GoogleSignupState {}

class GoogleSignupInitial extends GoogleSignupState {}

class GoogleSignupSucceed extends GoogleSignupState {
  final AUser user;

  GoogleSignupSucceed(this.user);
}

class GoogleSignupFailed extends GoogleSignupState {
  final String error;

  GoogleSignupFailed(this.error);

}

class GoogleSigningUp extends GoogleSignupState {}
