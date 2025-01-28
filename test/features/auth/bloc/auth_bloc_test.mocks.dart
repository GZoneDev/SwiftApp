// Mocks generated by Mockito 5.4.5 from annotations
// in receptico/test/features/auth/bloc/auth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:receptico/features/auth/service/auth_email_service.dart' as _i4;
import 'package:receptico/features/auth/service/auth_google_service.dart'
    as _i5;
import 'package:receptico/features/auth/service/auth_validation_service.dart'
    as _i6;
import 'package:receptico/features/auth/service/timer_service.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TimerService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimerService extends _i1.Mock implements _i2.TimerService {
  MockTimerService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<int> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<int>.empty(),
      ) as _i3.Stream<int>);

  @override
  bool get isRunning => (super.noSuchMethod(
        Invocation.getter(#isRunning),
        returnValue: false,
      ) as bool);

  @override
  _i3.Future<void> wait(int? seconds) => (super.noSuchMethod(
        Invocation.method(
          #wait,
          [seconds],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> stop() => (super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [AuthEmailService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthEmailService extends _i1.Mock implements _i4.AuthEmailService {
  MockAuthEmailService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.AuthError> registerEmail(
    String? username,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerEmail,
          [
            username,
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.AuthError>.value(_i4.AuthError.success),
      ) as _i3.Future<_i4.AuthError>);

  @override
  _i3.Future<_i4.AuthError> loginEmail(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginEmail,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.AuthError>.value(_i4.AuthError.success),
      ) as _i3.Future<_i4.AuthError>);

  @override
  _i3.Future<_i4.AuthError> sendResetPasswordEmail(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendResetPasswordEmail,
          [email],
        ),
        returnValue: _i3.Future<_i4.AuthError>.value(_i4.AuthError.success),
      ) as _i3.Future<_i4.AuthError>);

  @override
  _i3.Future<_i4.AuthError> sendVerificationEmail(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendVerificationEmail,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.AuthError>.value(_i4.AuthError.success),
      ) as _i3.Future<_i4.AuthError>);
}

/// A class which mocks [AuthGoogleService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthGoogleService extends _i1.Mock implements _i5.AuthGoogleService {
  MockAuthGoogleService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> signInWithGoogle() => (super.noSuchMethod(
        Invocation.method(
          #signInWithGoogle,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [AuthValidationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthValidationService extends _i1.Mock
    implements _i6.AuthValidationService {
  MockAuthValidationService() {
    _i1.throwOnMissingStub(this);
  }
}
