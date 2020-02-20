import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';

import 'package:tem_doacao_mobile/models/token_user.dart';
import 'package:tem_doacao_mobile/models/user.dart';
import 'package:tem_doacao_mobile/repositories/auth_repository.dart';

class MockHttpClient extends Mock implements dio.Dio {}

void main() {
  dio.Dio client;
  IAuthRepository repository;
  final String basePath = 'auth/';
  final TokenUser tokenUser = TokenUser(
    token: '123',
    user: User(
      id: '1',
      name: 'user',
      photoUrl: 'imagepath',
    ),
  );
  final Map dataSuccess = tokenUser.toJson();
  final resultException = HttpException('Something went wrong!');
  final String googleAccessToken = '42';

  setUp(() {
    client = MockHttpClient();
    repository = AuthRepository(client);
  });

  group('signInUp', () {
    final String resourcePath = '$basePath/sign-in-up/';

    void setUpSuccess() {
      when(client.post(resourcePath, data: {'google_access_token': googleAccessToken}))
        .thenAnswer((_) async => dio.Response(data: dataSuccess));
    }

    test('should build a request with corrects path and data', () async {
      setUpSuccess();

      await repository.signInUp(googleAccessToken);

      verify(client.post(resourcePath, data: {'google_access_token': googleAccessToken}));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.signInUp(googleAccessToken);

      expect(result, Right(tokenUser));
    });

    test('with failure', () async {
      when(client.post(resourcePath, data: {'google_access_token': googleAccessToken}))
        .thenThrow(resultException);

      final result = await repository.signInUp(googleAccessToken);

      expect(result, Left(Failure.from(resultException)));
    });
  });
}
