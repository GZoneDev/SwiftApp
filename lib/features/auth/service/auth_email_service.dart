import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum FirebaseAuthError {
  success('success'),

  // Login
  userDisabled('user-disabled'),
  userNotFound('user-not-found'),
  wrongPassword('wrong-password'),

  // Register
  emailAlreadyInUse('email-already-in-use'),
  invalidEmail('invalid-email'),
  operationNotAllowed('operation-not-allowed'),
  weakPassword('weak-password'),

  // Restore paasword
  resetInvalidEmail('invalid-email'),
  resetUserNotFound('user-not-found'),

  // Phone
  invalidVerificationCode('invalid-verification-code'),
  invalidVerificationId('invalid-verification-id'),
  quotaExceeded('quota-exceeded'),
  credentialAlreadyInUse('credential-already-in-use'),
  phoneOperationNotAllowed('operation-not-allowed'),

  // Update profile
  requiresRecentLogin('requires-recent-login'),

  // Common
  tooManyRequests('too-many-requests'),
  invalidCredential('invalid-credential'),
  networkRequestFailed('network-request-failed'),
  internalError('internal-error'),
  unknown('unknown');

  final String code;

  const FirebaseAuthError(this.code);

  static FirebaseAuthError fromCode(String code) {
    return FirebaseAuthError.values.firstWhere(
      (e) => e.code == code,
      orElse: () => FirebaseAuthError.unknown,
    );
  }

  get isSuccess => this == FirebaseAuthError.success;
}

abstract interface class IAuthEmailService {
  Future<FirebaseAuthError> registerWithEmail(String email, String password);
  Future<FirebaseAuthError> loginWithEmail(String email, String password);
  Future<FirebaseAuthError> resetPassword(String email);
  Future<bool> isEmailVerified();
}

class AuthEmailService implements IAuthEmailService {
  final _auth = FirebaseAuth.instance;
  final _loger = GetIt.I<Talker>();

  @override
  Future<FirebaseAuthError> registerWithEmail(
      final String email, final String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      _loger.log('User registered: ${credential.user?.email}');
      _loger.log('Verification email sent to: ${credential.user?.email}');

      return FirebaseAuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return FirebaseAuthError.fromCode(e.code);
    }
  }

  @override
  Future<FirebaseAuthError> loginWithEmail(
      final String email, final String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loger.log('User signed in: ${credential.user?.email}');
      return FirebaseAuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return FirebaseAuthError.fromCode(e.code);
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
      _loger.log('Sign-in methods for $email: $signInMethods');
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return false;
    }
  }

  @override
  Future<FirebaseAuthError> resetPassword(final String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _loger.log('Password reset email sent to $email');
      return FirebaseAuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return FirebaseAuthError.fromCode(e.code);
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }

    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _loger.log('User signed out');
  }
}
