import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';

void main() {
  final String message = 'failure message';
  final Failure failure = Failure(message);

  test('should accept the message in constructor', () {
    expect(message, failure.message);
  });

  group('should use the "from" factory to handle error/exception', () {
    test('FormatException', () {
      final failure = Failure.from(FormatException());

      expect(failure.message, isNot(DEFAULT_FAILURE_MESSAGE));
    });

    test('SocketException', () {
      final failure = Failure.from(SocketException(''));

      expect(failure.message, isNot(DEFAULT_FAILURE_MESSAGE));
    });

    test('HttpException', () {
      final failure = Failure.from(HttpException(''));

      expect(failure.message, isNot(DEFAULT_FAILURE_MESSAGE));
    });

    test('Unhandled Exception', () {
      // simulate unhandled exception
      final failure = Failure.from(FileSystemException());

      expect(failure.message, DEFAULT_FAILURE_MESSAGE);
    });
  });

  test('string representation', () {
    final stringRepresentation = failure.toString();

    final startRepresentation = '${failure.runtimeType.toString()} {';

    expect(stringRepresentation.startsWith(startRepresentation), true);
  });
}
