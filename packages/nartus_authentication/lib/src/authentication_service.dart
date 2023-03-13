import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nartus_authentication/exception/authentication_exception.dart';
import 'package:nartus_authentication/src/common.dart';

import '../data/user_data.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(
      {GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserDetail> signinGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } on PlatformException catch (e) {
      throw AuthUtils.convertAuthException(
          e.code, '${e.message} | ${e.details}');
    }

    if (googleUser == null) throw AuthenticateFailedException.userCancelled();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await _signInFirebase(oAuthCredential);

    return await getCurrentUser();
  }

  Future<UserDetail> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) throw AuthenticateFailedException.userNotFound();

    return UserDetail(
        name: firebaseUser.displayName,
        avatarUrl: firebaseUser.photoURL,
        phone: firebaseUser.phoneNumber,
        email: firebaseUser.email);
  }

  Future<void> _signInFirebase(AuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthUtils.convertAuthException(
          e.code, e.message ?? DefaultError.kErrUnknown);
    } catch (_) {
      throw AuthenticateFailedException.unknown();
    }
  }

  Future signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    _firebaseAuth.signOut();
  }
}
