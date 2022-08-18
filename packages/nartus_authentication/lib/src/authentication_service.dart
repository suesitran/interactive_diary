import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'user_data.dart';

abstract class IAuthenticationService {
  Future<AUser?> signinGoogle();
  Future<AUser?> getCurrentUser();
  Future<void> signOut();
}

class AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  AuthenticationService({GoogleSignIn? googleSignIn, FirebaseAuth? firebaseAuth}) :
    _googleSignIn = googleSignIn ?? GoogleSignIn(),
    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<AUser?> signinGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await _signInFirebase(oAuthCredential);

    return await getCurrentUser();
  }

  Future<AUser?> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    return AUser(
      name: firebaseUser.displayName!, avatarUrl: firebaseUser.photoURL!,
      phone: firebaseUser.phoneNumber, email: firebaseUser.email
    );
  }

  Future<void> _signInFirebase(AuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    _firebaseAuth.signOut();
  }
}