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
  Future<FirebaseAuthError> sendResetPasswordEmail(String email);
  Future<FirebaseAuthError> resendVerificationEmail();
  Future<bool> isEmailVerified();
}

class AuthEmailService implements IAuthEmailService {
  final _auth = FirebaseAuth.instance;
  final _loger = GetIt.I<Talker>();

  @override
  Future<FirebaseAuthError> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        _loger.log('Verification email resent to: ${user.email}');
        return FirebaseAuthError.success;
      } else if (user == null) {
        _loger.error('No user is currently logged in');
        return FirebaseAuthError.userNotFound;
      } else {
        _loger.log('Email is already verified');
        return FirebaseAuthError.emailAlreadyInUse;
      }
    } on FirebaseAuthException catch (e) {
      _loger.error('Error resending verification email: $e');
      return FirebaseAuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error resending verification email: $e');
      return FirebaseAuthError.unknown;
    }
  }

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
    } catch (e) {
      _loger.error('Error registration email/password: $e');
      return FirebaseAuthError.unknown;
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
    } catch (e) {
      _loger.error('Error login email/password: $e');
      return FirebaseAuthError.unknown;
    }
  }

  @override
  Future<FirebaseAuthError> sendResetPasswordEmail(final String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _loger.log('Password reset email sent to $email');
      return FirebaseAuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return FirebaseAuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error sent password reset email: $e');
      return FirebaseAuthError.unknown;
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
}
