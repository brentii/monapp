import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monapp/models/app_user.dart';

class AuthService {

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  //sign up a new user
  static Future<AppUser?> signUp(String em, String pw) async {
    try {
      
      final UserCredential credential = await _firebaseAuth.
        createUserWithEmailAndPassword(
          email: em,
          password: pw
      );
      if (credential.user != null) {
        return AppUser(
          uid: credential.user!.uid,
          email: credential.user!.email!
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //log users out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  //sign users in
  static Future<AppUser?> signIn(String em, String pw) async {
    try {
      
      final UserCredential credential = await _firebaseAuth.
        signInWithEmailAndPassword(
          email: em,
          password: pw
      );
      if (credential.user != null) {
        return AppUser(
          uid: credential.user!.uid,
          email: credential.user!.email!
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      print("BRENT LOG: ${userCredential.user!.displayName}");
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

}