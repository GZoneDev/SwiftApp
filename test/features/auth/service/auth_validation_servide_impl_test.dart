import 'package:flutter_test/flutter_test.dart';
import 'package:receptico/features/auth/service/implement/implement.dart';
import 'package:receptico/features/auth/service/service.dart';

void main() {
  late AuthValidationService authValidation;

  setUp(() {
    authValidation = AuthValidationServiceImpl();
  });

  group('AuthValidationService Test', () {
    group('Username validation Test', () {
      test('Username is empty', () {
        // Arrange
        const username = '';

        // Act
        final result = authValidation.usernameValidate(username);

        // Assert
        expect(EFormatError.requiredField, result);
      });
      test('Username is too short', () {
        // Arrange
        const username = 'shor';

        // Act
        final result = authValidation.usernameValidate(username);

        // Assert
        expect(EFormatError.tooShort, result);
      });

      test('Username is too long', () {
        // Arrange
        final username = List.generate(51, (index) => 'a').join();

        // Act
        final result = authValidation.usernameValidate(username);

        // Assert
        expect(EFormatError.tooLong, result);
      });

      test('Username contains invalid characters', () {
        // Arrange
        const username = '*3_fdggfD';

        // Act
        final result = authValidation.usernameValidate(username);

        // Assert
        expect(EFormatError.invalidCharacter, result);
      });

      test('Username is correct', () {
        // Arrange
        const username = 'Jango36';

        // Act
        final result = authValidation.usernameValidate(username);

        // Assert
        expect(null, result);
      });
    });

    group('Email validation Test', () {
      test('Email is empty', () {
        // Arrange
        const emptyEmail = '';

        // Act
        final result = authValidation.emailValidate(emptyEmail);

        // Assert
        expect(EFormatError.requiredField, result);
      });

      test('Email contains invalide characters', () {
        // Arrange
        const email = 'email-_.#@';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(EFormatError.invalidEmailFormat, result);
      });

      test('Email not contains @', () {
        // Arrange
        const email = 'email';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(EFormatError.invalidEmailFormat, result);
      });

      test('Email contains with incorrect domain', () {
        // Arrange
        const email = 'email@ffd';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(EFormatError.invalidEmailFormat, result);
      });

      test('Email contains with incorrect domain 2', () {
        // Arrange
        const email = 'email@ffd.dfd.';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(EFormatError.invalidEmailFormat, result);
      });

      test('Email contains with incorrect domain 3', () {
        // Arrange
        const email = 'email@ffd.dfd.fdg.';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(EFormatError.invalidEmailFormat, result);
      });

      test('Email correct', () {
        // Arrange
        const email = 'email@gmail.com';

        // Act
        final result = authValidation.emailValidate(email);

        // Assert
        expect(null, result);
      });
    });

    group('Password validation Test', () {
      test('Password is empty', () {
        // Arrange
        const emptyPassword = '';

        // Act
        final result = authValidation.passwordValidate(emptyPassword);

        // Assert
        expect(EFormatError.requiredField, result);
      });

      test('Password is too short', () {
        // Arrange
        const password = 'Ed12';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(EFormatError.tooShort, result);
      });

      test('Password missing uppercase', () {
        // Arrange
        const password = 'qwe124q';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(EFormatError.missingUppercase, result);
      });

      test('Password missing lowercase', () {
        // Arrange
        const password = 'QWS123SE';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(EFormatError.missingLowercase, result);
      });

      test('Password missing number', () {
        // Arrange
        const password = 'Qwertyq';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(EFormatError.missingNumber, result);
      });

      test('Password contains invalide character', () {
        // Arrange
        const password = 'Qwert1yq@#';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(EFormatError.invalidCharacter, result);
      });

      test('Password is correct', () {
        // Arrange
        const password = 'Qasf12rEf3';

        // Act
        final result = authValidation.passwordValidate(password);

        // Assert
        expect(null, result);
      });
    });
  });
}
