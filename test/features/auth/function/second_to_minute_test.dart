import 'package:flutter_test/flutter_test.dart';
import 'package:receptico/features/auth/common/function/second_to_minute.dart';

void main() {
  group('Function secondToMinute Test', () {
    test('Conversion seconds to single-digit seconds', () {
      // Arrange
      const expectedTime = '00:03';
      const seconds = 3;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to a smaller value per minute', () {
      // Arrange
      const expectedTime = '00:53';
      const seconds = 53;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to minute without seconds', () {
      // Arrange
      const expectedTime = '01:00';
      const seconds = 60;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to minute with single-digit seconds', () {
      // Arrange
      const expectedTime = '02:09';
      const seconds = 129;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to minute with seconds', () {
      // Arrange
      const expectedTime = '02:59';
      const seconds = 179;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to minute with seconds', () {
      // Arrange
      const expectedTime = '02:59';
      const seconds = 179;

      // Act
      final result = secondToMinute(seconds);

      // Assert
      expect(expectedTime, result);
    });

    test('Conversion seconds to minute with seconds', () {
      // Arrange
      const seconds = -1;

      // Act & Assert
      expect(() => secondToMinute(seconds), throwsA(isA<Exception>()));
    });

    test('Conversion seconds more 1 hour', () {
      // Arrange
      const seconds = 60 * 60;

      // Act & Assert
      expect(() => secondToMinute(seconds), throwsA(isA<Exception>()));
    });
  });
}
