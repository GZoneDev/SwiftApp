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
          when(mockAuthEmailService.loginWithEmail(any, any))
              .thenAnswer((_) async => AuthError.userNoVerified);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthFail(email: AuthError.userNoVerified.name),
        ],
        verify: (_) {
          verify(mockAuthEmailService.loginWithEmail('', '')).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLogin, AuthLoginSuccess] when AuthLogin is added',
        build: () {
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.loginWithEmail(any, any))
              .thenAnswer((_) async => AuthError.success);
          return authBloc;
        },
        act: (bloc) => bloc.add(AuthLogin(email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthLoginSuccess(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.loginWithEmail('', '')).called(1);
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
          when(mockAuthEmailService.registerWithEmail(any, any, any))
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
          verify(mockAuthEmailService.registerWithEmail('', '', '')).called(1);
        },
      );

      //TODO: fix mock stream
      blocTest<AuthBloc, AuthState>(
        'emits [AuthRegister, AuthRegisterSuccess] when AuthRegister is added',
        build: () {
          when(mockTimer.stream).thenAnswer((_) => Stream.periodic(
                Duration(seconds: 1),
                (count) => count,
              ).take(5));
          when(mockTimer.isRunning).thenReturn(false);
          when(mockTimer.stream).thenReturn(Stream.empty());
          when(mockAuthValidationService.usernameValidate(any))
              .thenReturn(null);
          when(mockAuthValidationService.emailValidate(any)).thenReturn(null);
          when(mockAuthValidationService.passwordValidate(any))
              .thenReturn(null);
          when(mockAuthEmailService.registerWithEmail(any, any, any))
              .thenAnswer((_) async => AuthError.success);
          return authBloc;
        },
        act: (bloc) =>
            bloc.add(AuthRegister(username: '', email: '', password: '')),
        expect: () => [
          AuthLoading(),
          AuthRegisterSuccess(),
        ],
        verify: (_) {
          verify(mockAuthEmailService.registerWithEmail('', '', '')).called(1);
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
