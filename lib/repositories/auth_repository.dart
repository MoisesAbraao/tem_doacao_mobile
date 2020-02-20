import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

import '../core/base_repositories.dart';
import '../core/errors/failures.dart';
import '../models/token_user.dart';

abstract class IAuthRepository implements BaseRestApiRepository {
  Future<Either<Failure, TokenUser>> signInUp(String googleAccessToken);
}

class AuthRepository implements IAuthRepository {
  final dio.Dio _client;

  AuthRepository(this._client);

  @override
  String get basePath => 'auth/';

  @override
  dio.Dio get client => _client;

  @override
  Future<Either<Failure, TokenUser>> signInUp(String googleAccessToken) async {
    try {
      final dio.Response response = await client.post(
        '$basePath/sign-in-up/',
        data: {
          'google_access_token': googleAccessToken,
        },
      );

      final TokenUser tokenUser = TokenUser.fromJson(response.data);

      return Right(tokenUser);
    } catch(e) {
      return Left(Failure.from(e));
    }
  }
}
