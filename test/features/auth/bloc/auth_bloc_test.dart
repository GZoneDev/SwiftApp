import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:receptico/features/auth/bloc/auth/auth_bloc.dart';
import 'package:receptico/features/auth/service/service.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([
  TimerService,
  AuthEmailService,
  AuthGoogleService,
  AuthValidationService,
])
void main() {
  late MockTimerService mockTimer;
  late MockAuthEmailService mockAuthEmailService;
  late MockAuthGoogleService mockAuthGoogleService;
  late MockAuthValidationService mockAuthValidationService;
  late Talker loger;
  late AuthBloc authBloc;

  setUp(() {
    mockTimer = MockTimerService();
    mockAuthEmailService = MockAuthEmailService();
    mockAuthGoogleService = MockAuthGoogleService();
    mockAuthValidationService = MockAuthValidationService();
    loger = Talker();

    authBloc = AuthBloc(
      validationService: mockAuthValidationService,
      restoreTimer: mockTimer,
      registerTimer: mockTimer,
      authEmailService: mockAuthEmailService,
      authGoogleService: mockAuthGoogleService,
      loger: loger,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('Auth Bloc Test', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    group('Login Test', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLogin AuthFail] when AuthLogin is added',
        build: () {
          when(mockAuthValidationService.emailValidate(any))
              .thenReturn(EFormatError.requiredField);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(email: '', password: '')),
        expect: () => [
          AuthFail(
            email: EFormatError.requiredField.name,
            password: EFormatError.requiredField.name,
          ),
        ],
        verify: (_) {
          verify(mockAuthValidationService.emailValidate('')).called(1);
          verify(mockAuthValidationService.passwordValidate('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLogin, AuthFail] when AuthLogin is added wrong email',
        build: () {
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.loginEmail(any, any))
              .thenAnswer((_) async => AuthError.userNoVerified);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthFail(email: AuthError.userNoVerified.name),
        ],
        verify: (_) {
          verify(mockAuthEmailService.loginEmail('', '')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLogin, AuthLoginSuccess] when AuthLogin is added',
        build: () {
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.loginEmail(any, any))
              .thenAnswer((_) async => AuthError.success);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthLoginSuccess(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.loginEmail('', '')).called(1);
        },
      );
    });

    group('Register Test', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthRegister AuthFail] when AuthRegister is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthValidationService.usernameValidate(any))
              .thenReturn(EFormatError.requiredField);
          when(mockAuthValidationService.emailValidate(any))
              .thenReturn(EFormatError.requiredField);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AuthRegister(username: '', email: '', password: '')),
        expect: () => [
          AuthFail(
            username: EFormatError.requiredField.name,
            email: EFormatError.requiredField.name,
            password: EFormatError.requiredField.name,
          ),
        ],
        verify: (_) {
          verify(mockAuthValidationService.usernameValidate('')).called(1);
          verify(mockAuthValidationService.emailValidate('')).called(1);
          verify(mockAuthValidationService.passwordValidate('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRegister, AuthFail] when AuthRegister is added wrong email',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthValidationService.usernameValidate(any))
              .thenReturn(null);
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.registerEmail(any, any, any))
              .thenAnswer((_) async => AuthError.emailAlreadyInUse);
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AuthRegister(username: '', email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthFail(email: AuthError.emailAlreadyInUse.name),
        ],
        verify: (_) {
          verify(mockAuthEmailService.registerEmail('', '', '')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRegister] when AuthRegister is added with locked',
        build: () {
          when(mockTimer.isRunning).thenReturn(true);
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AuthRegister(username: '', email: '', password: '')),
        expect: () => [],
        verify: (_) {
          verify(mockTimer.isRunning).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRegister, AuthRegisterSuccess] when AuthRegister is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthValidationService.usernameValidate(any))
              .thenReturn(null);
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.registerEmail(any, any, any))
              .thenAnswer((_) async => AuthError.success);
          when(mockAuthEmailService.sendVerificationEmail(any, any))
              .thenAnswer((_) async => AuthError.success);
          when(mockTimer.wait(any)).thenAnswer((_) async {});

          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AuthRegister(username: '', email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthRegisterSuccess(),
          AuthLoading(),
          AuthSendRegisterPasswordEmail(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.registerEmail('', '', '')).called(1);
          verify(mockAuthEmailService.sendVerificationEmail('', '')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthSendRegisterEmail] when AuthSendRegisterEmail is added with locked',
        build: () {
          when(mockTimer.isRunning).thenReturn(true);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthSendRegisterEmail(email: '', password: '')),
        expect: () => [],
        verify: (_) {
          verify(mockTimer.isRunning).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthSendRegisterEmail, AuthSendRegisterPasswordEmail] when AuthSendRegisterEmail is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthEmailService.sendVerificationEmail(any, any))
              .thenAnswer((_) async => AuthError.success);
          when(mockTimer.wait(any));
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthSendRegisterEmail(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthSendRegisterPasswordEmail(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.sendVerificationEmail('', '')).called(1);
          verify(mockTimer.wait(any)).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthSendRegisterEmail AuthEmailVerifiedSuccess] when AuthSendRegisterEmail is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthEmailService.sendVerificationEmail(any, any))
              .thenAnswer((_) async => AuthError.emailAlreadyInUse);
          when(mockTimer.wait(any));

          return authBloc;
        },
        act: (bloc) => bloc.add(AuthSendRegisterEmail(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthEmailVerifiedSuccess(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.sendVerificationEmail('', '')).called(1);
        },
      );
    });

    group('Restore Test', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthRestore AuthFail] when AuthRegister is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthEmailService.sendResetPasswordEmail(any))
              .thenAnswer((_) async => AuthError.userNotFound);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthRestore(email: '')),
        expect: () => [
          AuthLoading(),
          AuthFail(email: AuthError.userNotFound.name),
        ],
        verify: (_) {
          verify(mockAuthEmailService.sendResetPasswordEmail('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRestore] when AuthRestore is added with locked',
        build: () {
          when(mockTimer.isRunning).thenReturn(true);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthRestore(email: '')),
        expect: () => [],
        verify: (_) {
          verify(mockTimer.isRunning).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRestore AuthSendRestorePasswordEmail] when AuthRegister is added with success',
        build: () {
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockTimer.isRunning).thenReturn(false);
          when(mockTimer.wait(any)).thenAnswer((_) async => true);
          when(mockAuthEmailService.sendResetPasswordEmail(any))
              .thenAnswer((_) async => AuthError.success);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthRestore(email: '')),
        expect: () => [
          AuthLoading(),
          AuthSendRestorePasswordEmail(),
        ],
        verify: (_) {
          verify(mockTimer.isRunning).called(1);
        },
      );
    });

    group('Auth GoogleSignIn Test', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthGoogleSingIn AuthLoaded] when AuthGoogleSingIn is added server error',
        build: () {
          when(mockAuthGoogleService.signInWithGoogle())
              .thenAnswer((_) async => false);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthGoogleSingIn()),
        expect: () => [
          AuthLoading(),
          AuthLoaded(),
        ],
        verify: (_) {
          verify(mockAuthGoogleService.signInWithGoogle()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthGoogleSingIn AuthLoginSuccess] when AuthGoogleSingIn is added',
        build: () {
          when(mockAuthGoogleService.signInWithGoogle())
              .thenAnswer((_) async => true);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthGoogleSingIn()),
        expect: () => [
          AuthLoading(),
          AuthLoginSuccess(),
        ],
        verify: (_) {
          verify(mockAuthGoogleService.signInWithGoogle()).called(1);
        },
      );
    });

    group('Validation Test', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthUsernameValidate, AuthFail] when AuthUsernameValidate is added',
        build: () {
          when(mockAuthValidationService.usernameValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthUsernameValidate(value: '')),
        expect: () => [
          AuthFail(username: EFormatError.requiredField.name),
        ],
        verify: (_) {
          verify(mockAuthValidationService.usernameValidate('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthUsernameValidate, AuthFail] when AuthUsernameValidate is addedtwice with different responses',
        build: () {
          int callCount = 0;

          when(mockAuthValidationService.usernameValidate(any)).thenAnswer((_) {
            if (callCount == 0) {
              callCount++;
              return EFormatError.requiredField;
            } else {
              return null;
            }
          });
          return authBloc;
        },
        act: (bloc) {
          bloc.add(AuthUsernameValidate(value: ''));
          bloc.add(AuthUsernameValidate(value: ''));
        },
        expect: () => [
          AuthFail(username: EFormatError.requiredField.name),
          AuthFail(),
        ],
        verify: (_) {
          verify(mockAuthValidationService.usernameValidate('')).called(2);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthEmailValidate, AuthFail] when AuthEmailValidate is added error',
        build: () {
          when(mockAuthValidationService.emailValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthEmailValidate(value: '')),
        expect: () => [
          AuthFail(email: EFormatError.requiredField.name),
        ],
        verify: (_) {
          verify(mockAuthValidationService.emailValidate('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthEmailValidate, AuthFail] when AuthEmailValidate is addedtwice with different responses',
        build: () {
          int callCount = 0;

          when(mockAuthValidationService.emailValidate(any)).thenAnswer((_) {
            if (callCount == 0) {
              callCount++;
              return EFormatError.requiredField;
            } else {
              return null;
            }
          });
          return authBloc;
        },
        act: (bloc) {
          bloc.add(AuthEmailValidate(value: ''));
          bloc.add(AuthEmailValidate(value: ''));
        },
        expect: () => [
          AuthFail(email: EFormatError.requiredField.name),
          AuthFail(),
        ],
        verify: (_) {
          verify(mockAuthValidationService.emailValidate('')).called(2);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthPasswordValidate, AuthFail] when AuthPasswordValidate is added',
        build: () {
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthPasswordValidate(value: '')),
        expect: () => [
          AuthFail(password: EFormatError.requiredField.name),
        ],
        verify: (_) {
          verify(mockAuthValidationService.passwordValidate('')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthPasswordValidate, AuthFail] when AuthPasswordValidate is addedtwice with different responses',
        build: () {
          int callCount = 0;

          when(mockAuthValidationService.passwordValidate(any)).thenAnswer((_) {
            if (callCount == 0) {
              callCount++;
              return EFormatError.requiredField;
            } else {
              return null;
            }
          });
          return authBloc;
        },
        act: (bloc) {
          bloc.add(AuthPasswordValidate(value: ''));
          bloc.add(AuthPasswordValidate(value: ''));
        },
        expect: () => [
          AuthFail(password: EFormatError.requiredField.name),
          AuthFail(),
        ],
        verify: (_) {
          verify(mockAuthValidationService.passwordValidate('')).called(2);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthRestore AuthFail] when AuthRestore is added',
        build: () {
          when(mockTimer.isRunning).thenReturn(false);
          when(mockAuthValidationService.emailValidate(any))
              .thenReturn(EFormatError.requiredField);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthRestore(email: '')),
        expect: () => [
          AuthFail(
            email: EFormatError.requiredField.name,
          ),
        ],
        verify: (_) {
          verify(mockAuthValidationService.emailValidate('')).called(1);
        },
      );
    });
  });
}
