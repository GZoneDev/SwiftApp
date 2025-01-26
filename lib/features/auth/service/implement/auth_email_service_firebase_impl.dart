import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthEmailServiceFirebaseImpl implements AuthEmailService {
  final FirebaseAuth auth;
  final Talker loger;

  AuthEmailServiceFirebaseImpl({
    required this.auth,
    required this.loger,
  });

  @override
  Future<AuthError> resendVerificationEmail() async {
    try {
      final user = auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        loger.log('Verification email resent to: ${user.email}');
        return AuthError.success;
      } else if (user == null) {
        loger.error('No user is currently logged in');
        return AuthError.userNotFound;
      } else {
        loger.log('Email is already verified');
        return AuthError.emailAlreadyInUse;
      }
    } on FirebaseAuthException catch (e) {
      loger.error('Error resending verification email: $e');
      return AuthError.fromCode(e.code);
    } catch (e) {
      loger.error('Error resending verification email: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> registerWithEmail(
      final String email, final String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.sendEmailVerification();

      loger.log('User registered: ${credential.user?.email}');
      loger.log('Verification email sent to: ${credential.user?.email}');

      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      loger.error('Error registration email/password: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> loginWithEmail(
      final String email, final String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loger.log('User signed in: ${credential.user?.email}');
      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      loger.error('Error login email/password: $e');
      return AuthError.unknown;
    }
  }

  @override
  Future<AuthError> sendResetPasswordEmail(final String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      loger.log('Password reset email sent to $email');
      return AuthError.success;
    } on FirebaseAuthException catch (e) {
      loger.error(e.message);
      return AuthError.fromCode(e.code);
    } catch (e) {
      loger.error('Error sent password reset email: $e');
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
