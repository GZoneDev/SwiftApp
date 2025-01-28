import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:receptico/features/auth/service/auth_user_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AuthEmailServiceFirebaseImpl implements AuthEmailService {
  final AuthUserService userService;
  final FirebaseAuth auth;
  final Talker loger;

  AuthEmailServiceFirebaseImpl({
    required this.userService,
    required this.auth,
    required this.loger,
  });

  @override
  Future<AuthError> sendVerificationEmail(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        auth.signOut();

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
  Future<AuthError> registerEmail(
    String username,
    String email,
    String password,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        userService.create(credential.user!.uid, username, email);
        loger.log('User not found after register: ${credential.user?.email}');
        //TODO: need return fail
      }

      auth.signOut();

      loger.log('User registered: ${credential.user?.email}');

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
  Future<AuthError> loginEmail(
      final String email, final String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final isVerified = credential.user?.emailVerified ?? false;

      if (!isVerified) {
        auth.signOut();
        return AuthError.userNoVerified;
      }

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
}
