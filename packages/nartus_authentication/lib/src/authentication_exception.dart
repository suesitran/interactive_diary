
class AuthenticationException implements Exception {
  final String error;

  AuthenticationException(this.error);
}

class UserCancelledAuthenticationException extends AuthenticationException {
  UserCancelledAuthenticationException(super.error);
}

class NoUserFoundException extends AuthenticationException {
  NoUserFoundException(super.error);
}

class AuthenticateFailedException extends AuthenticationException {
  final AuthenticateStatus status;
  AuthenticateFailedException(this.status, super.error);
  AuthenticateFailedException.userCancelled() :
    status = AuthenticateStatus.userCanceled, super('User cancelled');
  AuthenticateFailedException.userNotFound() :
      status = AuthenticateStatus.userNotFound, super('User not found');
  AuthenticateFailedException.unknown({String? error}) :
      status = AuthenticateStatus.unknown, super(error ?? 'Unknown error');

  bool get isUserCanceled => status == AuthenticateStatus.userCanceled;
}

enum AuthenticateStatus {
  /// [START FIREBASE AUTH] signInWithCredential Exception
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
  accountExistsWithDifferentCredential,
  invalidCredential,
  operationNotAllowed,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidVerificationCode,
  invalidVerificationId,
  /// [END FIREBASE AUTH] signInWithCredential Exception

  /// [START GOOGLE] PlatformException
  userCanceled,
  /// [END GOOGLE] PlatformException

  unknown
}

class AuthUtils {
  static AuthenticateFailedException convertAuthException(String code, String message) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return AuthenticateFailedException(
          AuthenticateStatus.accountExistsWithDifferentCredential, message);
      case 'invalid-credential':
        return AuthenticateFailedException(
          AuthenticateStatus.invalidCredential, message);
      case 'operation-not-allowed':
        return AuthenticateFailedException(
          AuthenticateStatus.operationNotAllowed, message);
      case 'user-disabled':
        return AuthenticateFailedException(
          AuthenticateStatus.userDisabled, message);
      case 'user-not-found':
        return AuthenticateFailedException(
          AuthenticateStatus.userNotFound, message);
      case 'wrong-password':
        return AuthenticateFailedException(
          AuthenticateStatus.wrongPassword, message);
      case 'invalid-verification-code':
        return AuthenticateFailedException(
          AuthenticateStatus.invalidVerificationCode, message);
      case 'invalid-verification-id':
        return AuthenticateFailedException(
          AuthenticateStatus.invalidVerificationId, message);
      case 'sign_in_canceled':
        return AuthenticateFailedException(
          AuthenticateStatus.userCanceled, message);
      default:
        return AuthenticateFailedException(AuthenticateStatus.unknown, 'Unknown error');
    }
  }
}

