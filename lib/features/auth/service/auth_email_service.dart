import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum AuthError {
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

  const AuthError(this.code);

  static AuthError fromCode(String code) {
    return AuthError.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AuthError.unknown,
    );
  }

  get isSuccess => this == AuthError.success;
}

abstract interface class IAuthEmail {
  Future<AuthError> registerWithEmail(String email, String password);
  Future<AuthError> loginWithEmail(String email, String password);
  Future<AuthError> sendResetPasswordEmail(String email);
  Future<AuthError> resendVerificationEmail();
  Future<bool> isEmailVerified();
}

class AuthEmailService implements IAuthEmail {
  final _auth = FirebaseAuth.instance;
  final _loger = GetIt.I<Talker>();

  AuthEmailService();

  @override
  Future<AuthError> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        _loger.log('Verification email resent to: ${user.email}');
        return AuthError.success;
      } else if (user == null) {
        _loger.error('No user is currently logged in');
        return AuthError.userNotFound;
      } else {
        _loger.log('Email is already verified');
        return AuthError.emailAlreadyInUse;
      }
    } on FirebaseAuthException catch (e) {
      _loger.error('Error resending verification email: $e');
      return AuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error resending verification email: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> registerWithEmail(
      final String email, final String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      _loger.log('User registered: ${credential.user?.email}');
      _loger.log('Verification email sent to: ${credential.user?.email}');

      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error registration email/password: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> loginWithEmail(
      final String email, final String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loger.log('User signed in: ${credential.user?.email}');
      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error login email/password: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> sendResetPasswordEmail(final String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _loger.log('Password reset email sent to $email');
      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      _loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      _loger.error('Error sent password reset email: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      return FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    }

    return false;
  }
}
