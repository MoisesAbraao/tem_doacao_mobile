import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';

void main() {
  test('should accept the message in constructor', () {
    final String message = 'failure message';
    final Failure failure = Failure(message);

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
  });
}
