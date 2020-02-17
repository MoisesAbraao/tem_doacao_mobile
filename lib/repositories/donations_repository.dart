import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

import '../core/base_repositories.dart';
import '../core/errors/failures.dart';
import '../models/donation.dart';
import '../models/paginated_response.dart';

abstract class DonationsRepository implements BaseRestApiRepository {
  Future<Either<Failure, Donation>> getById(String id);

  Future<Either<Failure, PaginatedResponse<Donation>>> search(String query);

  Future<Either<Failure, PaginatedResponse<Donation>>> getRecents();

  Future<Either<Failure, PaginatedResponse<Donation>>> getByCursor(String cursor);
}

class DonationsRepositoryImpl implements DonationsRepository {
  final dio.Dio _client;

  DonationsRepositoryImpl(this._client);

  @override
  String get basePath => 'donations/';

  @override
  dio.Dio get client => _client;

  @override
  Future<Either<Failure, Donation>> getById(String id) async {
    try {
      final dio.Response response = await client.get('$basePath$id/');

      final donation = Donation.fromJson(response.data);

      return Right(donation);
    } catch(e) {
      return Left(Failure.from(e));
    }
  }

  Future<Either<Failure, PaginatedResponse<Donation>>> _getWithPath(String path) async {
    try {
      final dio.Response response = await client.get(path);

      final PaginatedResponse<Donation> paginatedResponse = PaginatedResponse(
        next: response.data['next'],
        prev: response.data['prev'],
        results: (response.data['results'] as List)
          .map((result) => Donation.fromJson(result))
          .toBuiltList()
      );

      return Right(paginatedResponse);
    } catch(e) {
      return Left(Failure.from(e));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> search(String query) {
    return _getWithPath('$basePath?search=$query');
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> getByCursor(String cursor) {
    return _getWithPath('$basePath?cursor=$cursor');
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> getRecents() {
    return _getWithPath('$basePath');
  }
}
