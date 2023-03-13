part of 'google_signup_bloc.dart';

abstract class GoogleSignupState {}

class GoogleSignupInitialState extends GoogleSignupState {}

class GoogleSignupSucceedState extends GoogleSignupState {
  final UserDetail user;

  GoogleSignupSucceedState(this.user);
}

class GoogleSignupFailedState extends GoogleSignupState {
  final String error;

  GoogleSignupFailedState(this.error);
}

class GoogleSigningUpState extends GoogleSignupState {}

extension GoogleSignupStateExtension on GoogleSignupState {
  bool get isSigningUp => this is GoogleSigningUpState;
  bool get isSignedUpSucceed => this is GoogleSignupSucceedState;
  bool get isSignedUpFailed => this is GoogleSignupFailedState;
  bool get isSignUpInitial => this is GoogleSignupInitialState;

  String get failedSignUpError =>
      isSignedUpFailed ? (this as GoogleSignupFailedState).error : '';
}
