import 'dart:async';

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

abstract interface class AuthEmailService {
  Future<AuthError> registerWithEmail(String email, String password);
  Future<AuthError> loginWithEmail(String email, String password);
  Future<AuthError> sendResetPasswordEmail(String email);
  Future<AuthError> resendVerificationEmail();
  Future<bool> isEmailVerified();
}
