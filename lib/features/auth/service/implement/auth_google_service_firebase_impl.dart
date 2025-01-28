import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:receptico/features/auth/service/auth_google_service.dart';
import 'package:receptico/features/auth/service/auth_user_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthGoogleServiceFirebaseImpl implements AuthGoogleService {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final Talker loger;
  final AuthUserService userService;

  AuthGoogleServiceFirebaseImpl({
    required this.loger,
    required this.googleSignIn,
    required this.auth,
    required this.userService,
  });

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      loger.log("Signed in as: ${user?.displayName}");

      if (user != null) {
        userService.create(user.uid, user.displayName, user.email);
      }

      return true;
    } catch (e) {
      loger.error("Error during Google sign-in: $e");
      return false;
    }
  }
}
