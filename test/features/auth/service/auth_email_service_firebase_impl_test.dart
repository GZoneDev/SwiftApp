import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:receptico/features/auth/service/implement/implement.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'auth_email_service_firebase_impl_test.mocks.dart';

@GenerateMocks([FirebaseAuth])
void main() {
  late AuthEmailService authEmail;
  late MockFirebaseAuth mockFirebaseAuth;
  late Talker loger;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    loger = Talker();
    authEmail = AuthEmailServiceFirebaseImpl(
      auth: mockFirebaseAuth,
      loger: loger,
    );
  });

  group('AuthEmailServiceFirebaseImpl Test', () {
    // group('Login Test', () {
    //   test('Username is empty', () {
    //     // Arrange
    //     const email = '', password = '';
    //     const expectedResult = AuthError.userNotFound;
    //     when(mockFirebaseAuth.signInWithEmailAndPassword(email: any, password: any)).thenAnswer((_) async => expectedResult.code);

    //     // Act
    //     final result = authEmail.loginEmail(email, password);

    //     // Assert
    //     expect(expectedResult, result);
    //   });
    // });
  });
}
